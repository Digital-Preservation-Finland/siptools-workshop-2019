Test Case 2 (Image data contents)
=================================

This test case consists of image data contents. Image data files require MIX
metadata blocks as additional technical metadata.

Prepararations
--------------

Go to the test folder::

	cd test_data/images_pkg/

View files and strucure of package::

	ls
	ls images/

Make a workspace directory::

	mkdir workspace

Scripts
-------

Run the following scripts in order.

1) Create technical metadata for all content files::

	import-object --workspace ./workspace images/

2) Create MIX technical metadata for image files (run once for each image
file)::

    create-mix --workspace ./workspace images/image_1.tif
    create-mix --workspace ./workspace images/image_2.jpeg

3) Create digital provenance data for the package::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP for a image data package' --event_target images/ --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

4) Wrap the descriptive metadata into a METS XML wrapper file::

	import-description dc_description.xml --workspace ./workspace --remove_root

5) Compile the structural map and create the file section::

	compile-structmap --workspace ./workspace 

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
