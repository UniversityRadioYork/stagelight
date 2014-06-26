STAGING_D=/usr/local/etc/apache24/staging.d
PREFIX='2013site-'


# Applies a prefix to a name.
# In:
#     $1 - The name to be prefixed.
# Out:
#     $name - The prefixed name.
SL_prefix_name()
{
  name="${PREFIX}$1"
}


# Removes a prefix from a name.
# In:
#     $1 - The name to be unprefixed.
# Out:
#     $uname - The unpreifxed name.
SL_unprefix_name()
{
  uname=$(echo $1 | sed "s/^${PREFIX}//")
}


# Deduces the config file of the given (full) staging site name.
# In:
#     $1 - The full name of the staging site including prefix.
# Out:
#     $file - The name of the file.
SL_file_from_name()
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
  host="http://localhost:$1"
}


# Normalises a path. 
# In:
#     $1 - A path.
# Out:
#     $path - The path with no trailing slash, etc.
SL_normalise_path()
{
  path=`echo $1 | sed 's|/$||'`
}


# Deduces the staging website name given its config file path.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $name - The name of the staging website (with prefix).
SL_name_from_file()
{
  name=`basename $1 | sed "s/.conf//"`
}


# Extracts the port number from a staging website config file.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $port - The port number of the staging website.
SL_port_from_file()
{
  port=`egrep -o 'https?:.*:[0-9]+' $1 | cut -f 3 -d: | head -n 1`
}


# Extracts the root directory from a staging website config file.
# In:
#     $1 - The path to the staging website's config file.
# Out:
#     $dir - The directory containing the staging website.
SL_dir_from_file()
{
    dir=`egrep -o '^# *DIR *.+' $1 | sed 's/# *DIR *//'`
}
