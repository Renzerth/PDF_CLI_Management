#!/bin/sh

## Display information to user to read information
echo "Programa para enviar archivos de la carpeta ID del paciente."
echo "Ingrese la Cédula del paciente:"
read PATIENT_ID_NUMBER

## Check that ID Number is integer
if ! echo $PATIENT_ID_NUMBER | egrep -q '^[0-9]+$'; then
   echo "La Cédula $PATIENT_ID_NUMBER no es un número" >&2; exit 1
fi

## Read contact information
echo "Ingrese el nombre del paciente:"
read PATIENT_NAME

echo "Ingrese el correo del paciente:"
read PATIENT_EMAIL


## Read text files for message templates
SUBJECT_TEMPLATE="$(cat "${HOME}/mail_subject_template_a.txt")"
MESSAGE_TEMPLATE="$(cat "${HOME}/mail_body_template_a.txt")"

## Update fields after substitution
FORMATTED_SUBJECT=$(eval echo -n ${SUBJECT_TEMPLATE})
FORMATTED_MESSAGE=$(eval echo -n ${MESSAGE_TEMPLATE})

# echo "$FORMATTED_MESSAGE" > ${HOME}/test.txt # Debug

## Send message with all attachments from target FOlder
cd ${HOME}/PDF_FILES
echo "${FORMATTED_MESSAGE}" | mutt -s "${FORMATTED_SUBJECT}" "${PATIENT_EMAIL}" -a *
