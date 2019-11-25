#!/bin/bash

# Example shell script for Pre-Ingest Workshop
#
# Finds all files in a directory (including sub-directories)
# and creates a SIP from those.
#
# Does not consider any error situations.
# Does not work with some file formats.
# Make sure that workspace exists and is empty before running.
# Use at your own risk. Not intended for production use as such.
#
# Usage:
#   pre_ingest_simple.sh base_path workspace dmd key tar_file
#   - base_path: Root path of the content
#   - workspace: Workspace path
#   - dmd: Descriptive metadata file (root element will be removed)
#   - key: Signature key filename
#   - tar_file: Output TAR file

# Change these as needed
EVENT_DETAIL="Creation of the content."
OUTCOME_DETAIL="Some outcome details"
PROFILE="ch"
ORGANIZATION="My Organization"
CONTRACT="47265f3e-f423-4926-9f27-7bab08508732"

# Find files from directory and sub-directories
FILES=$(find "$1" -type f -name "*")

# Import files and create technical metadata
for f in $FILES
do
    filerel=${f/$1}

    # file command does not work for all file formats.
    filetype=$(file --mime-type "$f" | cut -d" " -f2 | cut -d/ -f1)
    echo $filerel
    echo $filetype

    # Import file
    import-object "$filerel" --workspace "$2" --base_path "$1"

    if [ "$filetype" == "video" ]
    then
	# Only silent movies
	create-videomd "$filerel" --base_path "$1" --workspace "$2"
    elif [ "$filetype" == "audio" ]
    then
	create-audiomd "$filerel" --base_path "$1" --workspace "$2"
    elif [ "$filetype" == "image" ]
    then
	create-mix "$filerel" --base_path "$1" --workspace "$2"
    fi
done

# Create a creation event
now=$(date -d "now" "+%Y-%m-%dT%H:%M:%S")
premis-event creation "$now" --workspace "$2" --base_path "$1" \
    --event_detail "$EVENT_DETAIL" --event_outcome "success" \
    --event_outcome_detail "$OUTCOME_DETAIL" \
    --agent_name "Pre-Ingest Tool" --agent_type "software"

# Import descriptive metadata
import-description "$3" --workspace "$2" --base_path "$1" --remove_root

# Compile file section and compile structmap
compile-structmap --workspace "$2"

# Compile METS
compile-mets "$PROFILE" "$ORGANIZATION" "$CONTRACT" --workspace "$2" \
    --base_path "$1" --copy_files --clean

# Sign the SIP
sign-mets "$4" --workspace "$2"

# Create TAR file
compress "$2" --tar_filename "$5"

