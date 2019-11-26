Exercise 1 (Structured textual data)
====================================

The test package consists of text data. The data is structured in folders that are named with human readable folder names. The names are transferred to the structural metadata.
This exercise focuses on running the basic commands to create a valid SIP package.
The evaluation focuses on checking the output and comparing it to the original data as well as familiarizing the user with the metadata in the METS XML document.

Preparations
------------

Go to the test folder::

    cd test_data/structured_pkg/

View the files and the structure of the package::

    ls
    ls -laR contents/

Make a workspace directory::

    mkdir workspace

Scripts
-------

Run the following scripts in order.

1 - Create technical metadata for all content files::

    import-object --workspace ./workspace contents/

2 - Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts, or any other text for that matter)::

    premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP from a structured data package' --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

3 - Wrap the descriptive metadata into a METS XML wrapper file::

    import-description metadata_dc.xml --workspace ./workspace --remove_root

4 -  Compile the structural map and create the file section::

    compile-structmap --workspace ./workspace 

5 - Compile the METS document and copy content files into the workspace (feel free
to change the name of the organization)::

    compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

6 - Digitally sign the METS document::

    sign-mets --workspace ./workspace ../../cert/rsa-keys.crt

7 - Compress the workspace contents into a SIP archive in tar format::

    compress --tar_filename test-set1.tar ./workspace

Evaluation
----------

List the contents of the workspace::

    ls -laR workspace/

| Do the files ``mets.xml`` and ``signature.sig`` exist in the workspace?
| What does the ``contents/`` folder contain?

List the contents of the tar archive::

    tar -tvf workspace/test-set1.tar

Does the created tar archive contain all the files in the workspace?

View the created METS document::

    gedit workspace/mets.xml

|
| Look at the METS root element attributes, the ``CONTRACTID`` and the ``OBJID``.
|
| Take a look at the mets header (``metsHdr``) containing information about the creating organization.
|
| The descriptive metadata from the file ``metadata_dc.xml`` is just below the mets header, in the descriptive metadata section (``dmdSec``).
|
| Look at one of the technical metadata blocks described as ``premis:object`` metadata. What does the technical metadata tell us about the file format of the file in question?
|
| The METS structural map (``structMap``) is at the end of the document, look at the described structure and see how the directory structure and names are translated to the structural map.
|
| Take a look at the file section (``fileSec``) just above the structural map. Does the file section list all the files from the ``contents/`` folder?
| 
|

Finally, clean up the workspace::

    rm -rf workspace/*
