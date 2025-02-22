#!/bin/bash
#
# Does a backup of directories passed as arguments.

if [ "$#" -eq 0 ]; then
    echo "Error: Input at least one directory." >&2
    exit 1
fi

date_backup=$(date +"%Y%m%d_%H%M%S")
file_backup="backup"${date_backup}".tgz"

for dir in "$@"; do
  if [ -d "$dir" ]; then
    # If the argument is a valid directory, add it to the list
    dirs_to_backup+=("$dir")

    echo "Details of files in directory: $dir" >&1
    find "$dir" -exec stat --format="%A %U %G %x %y %z %n" {} \;
  else
    echo "Warning: $dir is not a valid directory, skipping." >&2
  fi
done

# Check if there are directories to back up
if [ "${#dirs_to_backup[@]}" -eq 0 ]; then
  echo "Error: No valid directories to back up. Exiting." >&2
  exit 1
fi

tar czpf "/usr/local/bin/${file_backup}" "${@}" >&1 >&2
