#!/bin/sh

running='yes'

MAIN_DIALOG_TXT="Choose an existing development website, or create a new one."


main_dialog()
{
  websites=$(lsstaging.sh | grep '^[^ ]* valid' | cut -f 1,3 -d ' ')

  dialog --title "Stagelight"                                               \
         --menu "${MAIN_DIALOG_TXT}" 0 0 0                                  \
         ""       "---- Existing Websites ----"                             \
         ${websites}                                                        \
         ""       "---- Other Actions ----"                                 \
         "Boot"   "Bootstraps a copy of the website code (in ./2013-site)." \
         "Create" "(SUDO) Creates a new development website entry."         \
         "Exit"   "Terminates Stagelight."                                  \
         2>/tmp/dialog.ans

  site=$(cat /tmp/dialog.ans)

  if [ \( -z "${site}" \) -o \( "$site" = "Exit" \) ]
  then
    running='no'
  elif [ "${site}" = "Boot" ]
  then
    wget https://urybsod.york.ac.uk/website.sh && sh ./website.sh
  elif [ "${site}" = "Create" ]
  then
    create_panel
  else
    site_panel ${site}
  fi
}


create_panel()
{
  dialog --title "Create Staging Website Entry"                                \
         --form  "Specify a name, port, and location on the filesystem." 0 0 0 \
         "Name (eg 'mattbw'):" 1 1 "$(whoami)"         1 21 30 0               \
         "Port (0-65535):    " 2 1 "8000"              2 21 5  0               \
         "Path to site copy: " 3 1 "${HOME}/2013-site" 3 21 30 0               \
         2>/tmp/dialog.ans
  result=$(xargs sudo mkstaging.sh </tmp/dialog.ans)
  if [ $? -ne 0 ]
  then
    dialog --title  "Error" \
           --msgbox "${result}" 0 0
  fi
}


site_panel()
{
  site=$1
  dialog --title "${site}"                                                  \
         --menu "$(chkstaging.sh ${site})" 0 0 0                            \
         'Run'    'Launches this development website (if you have access).' \
         'Delete' '(SUDO) Permanently removes this development website.'    \
         'Config' 'Opens the Pyramid config for this website in an editor.' \
         'Back'   'Go back to the list of development websites.'            \
         2>/tmp/dialog.ans

  answer=$(cat /tmp/dialog.ans)
  if [ "${answer}" = 'Run' ]
  then
    runstaging.sh "${site}"
  elif [ "${answer}" = 'Delete' ]
  then
    sudo rmstaging.sh "${site}"
  elif [ "${answer}" = 'Config' ]
  then
    cfgstaging.sh "${site}"
  fi
}


# Main loop
while [ "$running" = 'yes' ]
do
  main_dialog
done
