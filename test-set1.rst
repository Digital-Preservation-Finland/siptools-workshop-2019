Test Case 1 (Structured data)
=============================

This test case consists of data structured in folders that are named with a
human readable structural map in mind.

Prepararations
--------------

Go to the test folder::

	cd test_data/structured_pkg/

View files and strucure of package::

	ls
	ls contents/
	ls contents/Access\ and\ use\ rights\ files/

Make a workspace directory::

	mkdir workspace

Scripts
-------

Run the following scripts in order.

1) Create technical metadata for all content files::

	import-object --workspace ./workspace contents/

2) Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts)::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP from a structured data package' --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

3) Wrap the descriptive metadata into a METS XML wrapper file::

	import-description dc_description.xml --workspace ./workspace --remove_root

4) Compile the structural map and create the file section::

	compile-structmap --workspace ./workspace 

5) Compile the METS document and copy content files to the workspace (feel free
to change the name of the organization)::

	compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

6) Digitally sign the METS document::

	sign-mets --workspace ./workspace ../../dpres-siptools/tests/data/rsa-keys.crt

7) Compress the workspace contents to a SIP archive in tar format::

	compress --tar_filename sip.tar ./workspace

Evaluation
----------

List the contents of the tar archive::

	tar -tvf workspace/sip.tar

View the created METS document::

	gedit workspace/mets.xml

Finally, clean up the workspace::

	rm -rf workspace/*
