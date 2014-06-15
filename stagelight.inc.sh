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
