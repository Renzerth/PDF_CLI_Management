# A Summarized procedure to have SSMTP with MUTT
# Fill the corresponding fields in the config template files

[SSMTP INSTALLATION]

sudo apt install ssmtp
sudo nano /etc/ssmtp/ssmtp.conf

sudo chown root /etc/ssmtp/ssmtp.conf
sudo chmod 640 /etc/ssmtp/ssmtp.conf


[SSMTP revaliasses CONFIG]

sudo nano /etc/ssmtp/revaliasses


[MUTT INSTALATION]

sudo apt install mutt

mkdir -p ~/.mutt/cache/headers
mkdir ~/.mutt/cache/bodies
touch ~/.mutt/certificates
touch ~/.mutt/muttrc


[Possible paths of mutt config to edit]
~/.muttrc or ~/.mutt/muttrc or /etc/Muttrc

nano ~/.mutt/muttrc

set sendmail="/usr/sbin/ssmtp"

sudo chown root ~/.mutt/muttrc
sudo chmod 640 ~/.mutt/muttrc


[TESTING MUTT]

mutt -s "Test mail" -a  /tmp/file.tar.gz -- you@domain.com < /tmp/mailmessage.txt
# echo "" | mutt -s "subject" -i body.txt -a attachment.txt recipient@example.com

-s used to specify subject of mail.
-i used to specify file containing message body.
-a used to specify attachment file.

-b used to add Bcc address.
-c used to add Cc address.
-e if you want to specify sender's address (something other than default).


mutt -s "Test from mutt" user@yahoo.com < /tmp/message.txt
mutt -s "Test from mutt" user@yahoo.com < /tmp/message.txt -a /tmp/file.jpg
echo "This is the body" | mutt -s "Testing mutt" user@yahoo.com -a /tmp/XDefd.png

mutt -s "Test from mutt" myMail@do.main < ${HOME}/test_mail.txt -a ${HOME}/frame_0.jpg

test_mail.txt is the body of the message. frame_0 is an attachment.
