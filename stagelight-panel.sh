#!/bin/sh

running='yes'

MAIN_DIALOG_TXT="Foo"

main_dialog()
{
	websites=$(lsstaging.sh | grep '^[^ ]* valid' | cut -f 1,3 -d ' ')

	dialog --menu "${MAIN_DIALOG_TXT}" 0 0 0 ${websites} \
		--title "Staging Websites" \
	       	2>/tmp/dialog.ans

	site=$(cat /tmp/dialog.ans)
	if [ -z "${site}" ]
	then
		running='no'
	else
		site_panel
	fi
}

site_panel()
{

	dialog --msgbox "boo" 0 0 --title "${site}"
}

while [ "$running" = 'yes' ]
do

main_dialog

done
