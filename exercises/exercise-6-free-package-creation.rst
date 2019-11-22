Exercise 5 (Define your own package)
====================================

This test case consists of an unstructured package containing a lot of files.
This is an advanced exercise. The goal is to create a package and a structure
that could resemble a real life case, for example using your own organization
as an example. Create an complex folder structure and copy fitting files to
their correct locations. Remove unnecessary files.

Preparations
------------

Go to the test folder::

    cd test_data/free_pkg/

View the files and the structure of the package::

    ls
    ls data-files/
    ls metadata/

Make a workspace directory::

    mkdir workspace

Create a folder structure using the mkdir command::

    mkdir <folder>/>subfolder>

Move files to their intended folder::

    mv data-files/<file-to-be-moved> <destination folder>

Remove unnecessary files::

    rm data-files/<remove-me>

Scripts
-------

Run the following scripts and repeat them if necessary:

import_description
    for adding a descriptive metadata section to a METS document.

premis_event
    for creating digital provenance metadata.

import_object
    for adding technical metadata for digital objects to a METS document.

create_mix
    for creating MIX metadata for image files.

create_addml
    for creating ADDML metadata for csv files.

create_audiomd
    for creating AudioMD metadata for audio streams.

create_videomd
    for creating VideoMD metadata for video streams.

compile_structmap
    for creating the file section and structural map.

compile_mets
    for compiling all previously created metadata files in a METS document.

sign_mets
    for digitally signing the submission information package.

compress
    for wrapping the created submission information package directory into a TAR file.

Evaluation
----------

View the created METS document::

    gedit workspace/mets.xml

Take specific note at the created structural map. How well does it represent
your intentions?

Validation (optional)
---------------------

These validation steps can check the created metadata, compare the recorded
checksum against the actual digital objects and validate the file formats
themselves against the created metadata.

Validate the METS document against the schema::

    check-xml-schema-features workspace/mets.xml

Perform additional validation of the METS document like this (it outputs a file
called output1.txt)::

    for i in $(ls /usr/share/dpres-xml-schemas/schematron/*.sch); do check-xml-schematron-features -s $i workspace/mets.xml ; done > output1.txt

Grep the output1.txt file for successful or failed patterns (it isn't really
human readable)::

    grep failed output1.txt
    grep patterns output1.txt

Validate the checksums recorded in the METS document against the actual files::

    check-sip-file-checksums workspace/

Validate the file format and version reported in the METS document against the
actual files using different validators installed with the file-scraper tool::

    check-sip-digital-objects workspace/ test test > output2.txt

Grep the output2.txt file for successful or failed events::

    grep failure output2.txt
    grep success output2.txt

Finally, clean up the workspace::

    rm -rf workspace/*
