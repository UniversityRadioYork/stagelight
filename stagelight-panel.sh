#!/bin/sh

. stagelight.inc.sh

panel='main'

MAIN_DIALOG_TXT="Welcome to the Stagelight main menu.\n\
\n
From here, you can see the staging websites set up on this server, \
or create a new one."

SITES_DIALOG_TXT="Choose an existing development website.\n\
\
Alternatively, select 'Back' to return to the main menu."


main_panel()
{
  tempfile=$(mktemp)

  dialog --title "Stagelight"                                               \
         --menu "${MAIN_DIALOG_TXT}" 0 0 0                                  \
         "Sites"  "View, and work with, existing staging websites."         \
         "Boot"   "Bootstraps a copy of the website code (in ./2013-site)." \
         "Create" "(SUDO) Creates a new development website entry."         \
         "Exit"   "Terminates Stagelight."                                  \
         2>"${tempfile}"

  opt=$(cat "${tempfile}")

  case "${opt}" in
    'Sites'  ) panel='sites' ;;
    'Boot'   )
      wget "${BOOTSTRAP}" && sh "${BOOTSTRAP_FN}"
      panel='main'
      ;;
    'Create' ) panel='create' ;;
    'Exit'   ) panel='quit'   ;;
    *        ) panel='quit'   ;;
  esac
}

sites_panel()
{
  tempfile=$(mktemp)

  echo "Fetching website information.  This may take a while..."
  websites=$(lsstaging.sh | grep '^[^ ]* valid' | cut -f 1,3 -d ' ')
  dialog --title "Sites"                        \
         --menu "${SITES_DIALOG_TXT}" 0 0 0      \
         ""       "---- Existing Websites ----" \
         ${websites}                            \
         ""       "---- Other Actions ----"     \
         "Back"   "Go back to the main menu."   \
         2>"${tempfile}"

  site=$(cat "${tempfile}")
  
  case "${site}" in
    'Back' ) panel='main' ;;
    ''     ) panel='main' ;;
    *      ) panel='site' ;;
  esac
}

create_panel()
{
  tempfile=$(mktemp)
  panel='main'

  dialog --title "Create Staging Website Entry"                                \
         --form  "Specify a name, port, and location on the filesystem." 0 0 0 \
         "Name (eg 'mattbw'):" 1 1 "$(whoami)"         1 21 30 0               \
         "Port (0-65535):    " 2 1 "8000"              2 21 5  0               \
         "Path to site copy: " 3 1 "${HOME}/2013-site" 3 21 30 0               \
         2>"${tempfile}"
  result=$(xargs sudo mkstaging.sh <"${tempfile}")
  if [ $? -ne 0 ]
  then
    dialog --title  "Error" \
           --msgbox "${result}" 0 0
  fi
}


# Expects $site to be set to the correct site.
site_panel()
{
  tempfile=$(mktemp)
  chkresult=$(chkstaging.sh "${site}")

  dialog --title "${site}"                                                  \
         --menu "${chkresult}" 0 0 0                                        \
         'Run'    'Launches this development website (if you have access).' \
         'Delete' '(SUDO) Permanently removes this development website.'    \
         'Config' 'Opens the Pyramid config for this website in an editor.' \
         'Back'   'Go back to the list of development websites.'            \
         2>"${tempfile}"

  case $(cat "${tempfile}") in
    'Run'    ) runstaging.sh "${site}"     ;;
    'Delete' ) sudo rmstaging.sh "${site}" ;;
    'Config' ) cfgstaging.sh "${site}"     ;;
    'Back'   ) panel='sites'               ;;
    *        ) panel='sites'               ;;
  esac
}


# Main loop
while [ "${panel}" != 'quit' ]
do
  case ${panel} in
    'main'   ) main_panel   ;;
    'sites'  ) sites_panel  ;;
    'site'   ) site_panel   ;;
    'create' ) create_panel ;;
    *        ) echo "bug: unknown panel: ${panel}";;
  esac
done
