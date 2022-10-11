#!/bin/bash

file_counter=0

## Define Work Folders
TARGET_FOLDER="$HOME/PATIENTS"
CURRENT_DATE_FOLDER=$(date +"%d-%m-%Y")
MONTH_NAME_FOLDER=$(date +%^B)
WORK_DIRECTORY="$TARGET_FOLDER/$MONTH_NAME_FOLDER/$CURRENT_DATE_FOLDER"

echo "Programa para mover archivos a la carpeta ID del paciente."
echo "Ingrese la Cédula del paciente:"
read PATIENT_ID_NUMBER


## Check that ID Number is integer
if ! echo $PATIENT_ID_NUMBER | egrep -q '^[0-9]+$'; then
   echo "La Cédula no es un número" >&2; exit 1
fi


## Count pdf files in target folder to avoid overwritting if it has files
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


## Notify and Close
#echo "Archivos movidos correctamente."

exit

