Exercise 5 (Validate the data)
==============================

This test case consists of both valid and invalid contents. The goal is to create either an valid or invalid pckage and validate the data using the validation tools provided by the DPS. In this exercise we also use the wellformedness validation built into the pre-ingest tool.

Preparations
------------

Go to the test folder::

    cd test_data/validation_pkg/

View the files and the structure of the package::

    ls
    ls data/

Make a workspace directory::

    mkdir workspace

Scripts
-------

1 - Create technical metadata for a broken file skipping the wellformedness check::

    import-object --workspace ./workspace data/image_png_invalid.png --skip_wellformed_check

Notice how the technical metadata generation passed without errors.

2 - Now, try to create technical metadata for the same file while validating the wellformedness::

    import-object --workspace ./workspace data/image_png_invalid.png

The metadata creation should fail.

Now create metadata for the valid file and run all the basic scripts needed to create the package::

    import-object --workspace ./workspace data/image_png_valid.png

    premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP from a structured data package' --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

    import-description metadata_dc.xml --workspace ./workspace --remove_root

    compile-structmap --workspace ./workspace

    compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

Validation
----------

These validation steps can check the created metadata, compare the recorded
checksum against the actual digital objects and validate the file formats
themselves against the created metadata.

Validate the METS document against the schema::

    check-xml-schema-features workspace/mets.xml

The METS document should be valid according to the XML schema.

Perform additional validation of the METS document like this (it outputs a file
called output1.txt)::

    for i in $(ls /usr/share/dpres-xml-schemas/schematron/*.sch); do check-xml-schematron-features -s $i workspace/mets.xml ; done > output1.txt

Grep the output1.txt file for successful or failed patterns (it isn't really
human readable)::

    grep -C 3 failed output1.txt
    grep -C 3 patterns output1.txt

Validate the checksums recorded in the METS document against the actual files::

    check-sip-file-checksums workspace/

Validate the file format and version reported in the METS document against the
actual files using different validators installed with the file-scraper tool::

    check-sip-digital-objects workspace/ test test > output2.txt

Grep the output2.txt file for successful or failed events::

    grep failure -B 5 -A 15 output2.txt
    grep success output2.txt

Finally, clean up the workspace::

    rm -rf workspace/*
