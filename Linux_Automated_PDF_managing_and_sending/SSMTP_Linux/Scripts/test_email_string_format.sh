regex_email="^([A-Za-z0-9]+[A-Za-z0-9]*\+?((\.|\-|\_)?[A-Za-z0-9]+[A-Za-z0-9]*)*)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"
read RECIPIENT_EMAIL

if ! echo $RECIPIENT_EMAIL | egrep -q $regex_email; then
   echo "PACIENTE SIN CORREO."
else
   echo "PACIENTE CON CORREO."
fi
