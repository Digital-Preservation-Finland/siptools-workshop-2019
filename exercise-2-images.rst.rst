Exercise 2 (Image data contents)
================================

This test case consists of image data contents. Image data files require MIX
metadata blocks as additional technical metadata.
The exercise focuses on creating mandatory technical metadata for image files.
In the evaluation the user is asked to evaluate the images technical properties by exploring the created techincal metadata.

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

1 - Create technical metadata for all content files::

	import-object --workspace ./workspace images/

2 - Create MIX technical metadata for image files (run once for each image
file)::

    create-mix --workspace ./workspace images/image_tiff_1.tif
    create-mix --workspace ./workspace images/image_jpeg_2.jpeg
    create-mix --workspace ./workspace images/image_jpeg_3.jpeg

3 - Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts, or any other text as you see fit)::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP for a image data package' --event_target images/ --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

4 - Wrap the descriptive metadata into a METS XML wrapper file::

	import-description metadata_dc.xml --workspace ./workspace --remove_root

5 - Compile the structural map and create the file section::

	compile-structmap --workspace ./workspace 

6 - Compile the METS document and copy content files to the workspace (feel free
to change the organization name)::

	compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

7 - Digitally sign the METS document::

	sign-mets --workspace ./workspace ../../cert/rsa-keys.crt

8 - Compress the workspace contents to a SIP archive in tar format::

	compress --tar_filename test-set2.tar ./workspace

Evaluation
----------

List the contents of the tar archive::

	tar -tvf workspace/test-set2.tar

View the created METS document::

	gedit workspace/mets.xml

|
| Look at the created technical metadata blocks within the mets administrative metadata section (``amdSec``). The ``premis:object`` and ``mix`` blocks describe the images' technical properties. The number of ``premis`` and ``mix`` blocks respectively should equal the number of image files.
|
| What do the technical metadata blocks tell you about the files' technical properties?
| 
| Look at the file section (``fileSec``) just above the structural map. Do all image files have at least two ``ADMID`` links, one to a premis block and another to a mix block?
|
| 

Finally, clean up the workspace::

	rm -rf workspace/*
