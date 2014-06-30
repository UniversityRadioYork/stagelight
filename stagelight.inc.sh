# Source the stagelight config first, and die if it couldn't be found.
for loc in "/etc" "/usr/etc" "/usr/local/etc" "."
do
  if [ -f "${loc}/stagelightrc" ]
  then
    . "${loc}/stagelightrc"
  fi
done

if [ -z "${STAGING_D}" ]
then
  echo "[!] Couldn't load Stagelight configuration."
  echo "    Check the Stagelight README for details."
  exit
fi


# Checks the script arguments to see if a staging site name has been given,
# dies if there isn't one, and populates some variables if there is one.
#
# In:
#     $1     - The original value of $#.
#     $2     - The original value of $1.
# Out:
#     $uname - The unprefixed name of the staging site (the argument).
#     $name  - The prefixed name of the staging site.
#     $file  - The location of the staging site's config file.
#     $url   - The WWW location of the staging site, when it is active.
#     
SL_check_name_argument()
{
  if [ "$1" -ne 1 ]
  then
    echo "[!] Usage: $0 NAME."
    echo "    (eg: $0 mattbw)"
    exit
  fi

  uname=$2
  SL_prefix_name    "${uname}" # -> name
  SL_file_from_name "${name}"  # -> file
  SL_url_from_name  "${name}"  # -> url
}


# Applies a prefix to a name.
# In:
#     $1 - The name to be prefixed.
# Out:
#     $name - The prefixed name.
SL_prefix_name()
{
  name="${PREFIX}${1}"
}


# Removes a prefix from a name.
# In:
#     $1 - The name to be unprefixed.
# Out:
#     $uname - The unprefixed name.
SL_unprefix_name()
{
  uname="${1#${PREFIX}}"
}


# Deduces the URL of the given (full) staging site name.
# In:
#     $1 - The full name of the staging site including prefix.
# Out:
#     $url - The URL of the website.
SL_url_from_name()
{
  url="${WEBSITE}/${1}"
}


# Deduces the config file of the given (full) staging site name.
#
# Exits with status 2 if the config file does not exist.
# In:
#     $1 - The full name of the staging site including prefix.
# Out:
#     $file - The name of the file.
SL_file_from_name()
{
  SL_file_from_name_nocheck "${1}"

  if [ ! \( -f "${file}" \) ]
  then
    echo "[!] Staging website ${1} does not exist."
    echo "    Please try a different name."
    exit 2
  fi
}


# Deduces the config file of the given (full) staging site name.
#
# Does not check to see if the file exists.
# In:
#     $1 - The full name of the staging site including prefix.
# Out:
#     $file - The name of the file.
SL_file_from_name_nocheck()
{
  file="${STAGING_D}/${1}.conf"
}


# Deduces the full host given a port number.
# In:
#     $1 - The port number.
# Out:
#     $host - The full host (eg http://localhost:PORT).
SL_host_from_port()
{
  host="http://localhost:${1}"
}


# Normalises a path. 
# In:
#     $1 - A path.
# Out:
#     $path - The path with no trailing slash, etc.
SL_normalise_path()
{
  path="${1%/}"
}


# Checks if a config file exists and, if it does, extracts data from it.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $port - The port number of the staging website.
#     $dir - The directory containing the staging website.
SL_probe_config()
{
  SL_port_from_file "${1}"
  SL_dir_from_file "${1}"
}


# Deduces the staging website name given its config file path.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $name - The name of the staging website (with prefix).
SL_name_from_file()
{
  name=$(basename "${1}")
  name=${name%.conf}
}


# Extracts the port number from a staging website config file.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $port - The port number of the staging website.
SL_port_from_file()
{
  port=$(egrep -o 'https?:.*:[0-9]+' "${1}" | cut -f 3 -d: | head -n 1)
}


# Extracts the root directory from a staging website config file.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $dir - The directory containing the staging website.
SL_dir_from_file()
{
    dir=$(egrep -o '^# *DIR *.+' "${1}" | sed 's/# *DIR *//')
}


# Tests whether a staging site is up and running.
#
# In:
#     $1 - The URL to the staging website.
# Out:
#     $scode  - The HTTP status code of the site: 200 is OK.
#     $status - A human-readable summary of $scode.
SL_test_site_up()
{
  scode=$(curl "${url}" -so /dev/null --write-out "%{http_code}")
  if [ "${scode}" = "200" ]
  then
    status="up-${scode}"
  else
    status="down-${scode}"
  fi
}
