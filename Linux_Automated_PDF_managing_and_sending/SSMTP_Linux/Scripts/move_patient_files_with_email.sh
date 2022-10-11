#!/bin/bash

file_counter=0

## Mail Templates text files directory
MAIL_TEMPLATES_DIRECTORY="${HOME}/Scripts/send_email"

## Define Work Folders
TARGET_FOLDER="${HOME}/PATIENTS"
CURRENT_DATE_FOLDER=$(date +"%d-%m-%Y")
MONTH_NAME_FOLDER=$(date +%^B)
WORK_DIRECTORY="$TARGET_FOLDER/$MONTH_NAME_FOLDER/$CURRENT_DATE_FOLDER"

## Display information to user to read information
echo "Programa para mover y enviar archivos del paciente."
echo -n -e "Se envía la información a la dirección de correo especificada.\n\n"
echo "Ingrese la Cédula del paciente:"
read PATIENT_ID_NUMBER


## Check that ID Number is an integer
if ! echo $PATIENT_ID_NUMBER | egrep -q '^[0-9]+$'; then
   echo "La Cédula no es un número" >&2; exit 1
fi

## Read contact information
echo -n -e "\n"
echo "Ingrese el nombre del paciente:"
read PATIENT_NAME

echo -n -e "\n"
echo "Ingrese el correo del paciente:"
read RECIPIENT_EMAIL

## Check if mail has '@' to define if patient has an email to send
regex_email="^([A-Za-z0-9]+[A-Za-z0-9]*\+?((\.|\-|\_)?[A-Za-z0-9]+[A-Za-z0-9]*)*)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"


## Choose mail templates if valid patien mail

WORK_RECIPIENT="$(cat "${MAIL_TEMPLATES_DIRECTORY}/work_email_list.txt")"

if ! echo $RECIPIENT_EMAIL | egrep -q $regex_email; then
   echo "PACIENTE SIN CORREO."
   RECIPIENT_EMAIL="${WORK_RECIPIENT}" # if not a valid patient mail, send only to workfront with work template

   SUBJECT_TEMPLATE="$(cat "${MAIL_TEMPLATES_DIRECTORY}/mail_subject_template_b.txt")"
   MESSAGE_TEMPLATE="$(cat "${MAIL_TEMPLATES_DIRECTORY}/mail_body_template_b.txt")"

   COPY_ADDRESSES=""

else
   echo "PACIENTE CON CORREO." # if valid patient mail, send to patient and workfront, as a copy, with patient template

   SUBJECT_TEMPLATE="$(cat "${MAIL_TEMPLATES_DIRECTORY}/mail_subject_template_a.txt")"
   MESSAGE_TEMPLATE="$(cat "${MAIL_TEMPLATES_DIRECTORY}/mail_body_template_a.txt")"

   COPY_ADDRESSES="${WORK_RECIPIENT}"

fi


## Update fields after substitution
FORMATTED_SUBJECT=$(eval echo -n ${SUBJECT_TEMPLATE})
FORMATTED_MESSAGE=$(eval echo -n ${MESSAGE_TEMPLATE})


## Count pdf files in target folder to avoid overwritting if it has already files in
CURRENT_PATIENT_FOLDER="$WORK_DIRECTORY/$PATIENT_ID_NUMBER"
EXISTING_FILES_COUNTER=$(find "$CURRENT_PATIENT_FOLDER" -mindepth 1 -maxdepth 1 -type f -name "*.pdf" -printf x | wc -c)
file_counter=$((file_counter+$EXISTING_FILES_COUNTER))
mkdir -p "${CURRENT_PATIENT_FOLDER}"


## Rename and move all files to corresponding ID Number
for PDF_FILE_NAME in *.pdf
do
file_counter=$((file_counter+1))
NEW_PDF_FILE_NAME="$PATIENT_ID_NUMBER-$file_counter.pdf"
mv "$PDF_FILE_NAME" "$CURRENT_PATIENT_FOLDER/$NEW_PDF_FILE_NAME"
done


## Send message with all attachments from target Folder
echo -n -e "\n"
cd "${CURRENT_PATIENT_FOLDER}" # Change folder to attatch all files in directory
echo -n -e "${FORMATTED_MESSAGE}" | mutt -s "${FORMATTED_SUBJECT}" -c "${COPY_ADDRESSES}" -a * -- "${RECIPIENT_EMAIL}"
#echo -n -e "TO:${RECIPIENT_EMAIL}\n\nCC:${COPY_ADDRESSES}\n\nSUBJECT:${FORMATTED_SUBJECT}\n\n\n${FORMATTED_MESSAGE}" > ${HOME}/Desktop/mail_test.txt

## Notify and Close
#echo "Archivos enviados correctamente."

exit

