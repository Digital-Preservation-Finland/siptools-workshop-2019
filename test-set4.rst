Test Case 3 (EAD3 finding aid package)
========================================

This test case consists of a package containing an EAD3 finding aid file. The
METS structural map can be creating using the structure contained within the
EAd3 metadata. This package also contains a CSV file, that reqiures ADDML
metadata to describe its structure.

Prepararations
--------------

Go to the test folder::

	cd test_data/ead3_pkg/

View files and strucure of package::

	ls

Make a workspace directory::

	mkdir workspace

Scripts
-------

Run the following scripts in order.

1) Create technical metadata for all content files::

    import-object --workspace ./workspace csv-file.csv
    import-object --workspace ./workspace pdf-document.pdf
    import-object --workspace ./workspace text-file1.txt
    import-object --workspace ./workspace text-file2.txt

2) Create ADDML technical metadata for CSV files (run once for each CSV file)::

    create-addml csv-file.csv --charset 'UTF8' --delim ',' --sep 'LF' --quot '"'

3) Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts, or any other text for that matter)::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP for an EAD3 data package' --event_target data/ --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

4) Wrap the descriptive metadata into a METS XML wrapper file::

    import-description ead3-finding-aid.xml --workspace ./workspace

5) Compile the structural map and create the file section::

    compile-structmap --workspace ./workspace --structmap_type 'EAD3-logical' --dmdsec_loc ead3-finding-aid.xml

6) Compile the METS document and copy content files to the workspace (feel free
to change the organization name)::

	compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

7) Digitally sign the METS document::

	sign-mets --workspace ./workspace ../../dpres-siptools/tests/data/rsa-keys.crt

8) Compress the workspace contents to a SIP archive in tar format::

	compress --tar_filename sip.tar ./workspace

Evaluation
----------

List the contents of the tar archive::

	tar -tvf workspace/sip.tar

View the created METS document::

	gedit workspace/mets.xml

Finally, clean up the workspace::

	rm -rf workspace/*
