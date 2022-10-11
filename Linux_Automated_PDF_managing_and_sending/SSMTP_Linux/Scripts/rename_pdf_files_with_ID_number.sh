#!/bin/sh
echo "Escriba la Cédula del paciente."
read CEDULA

echo "\nCarpeta Número:"
read FOLDER

WORK_DIR="$HOME/Desktop/$FOLDER/"

cd $WORK_DIR

num=1
for file in *.pdf; do
	mv "$file" "$CEDULA-$num.pdf"
	num=$(($num+1))
done