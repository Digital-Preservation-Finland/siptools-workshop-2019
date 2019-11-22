Exercise 5 (Ordered data with multiple descriptions and events)
===============================================================

This test case consists of data that requires that the digital objects are represented in a typical order. A part of the data is described using another descriptive metadata set. The provenance information consists of multiple events that only apply to certain files.
The exercise focuses on creating ordered structural metadata for the files. Multiple events and descriptions, that target only portions of the data are created as part of this exercise.
In the evaluation the user is asked to focus on the internal linkings within the METS XML document. The goal is to see how the descriptive metadata and the provenance history can target parts of the contents within a package.

Preparations
--------------

Go to the test folder::

    cd test_data/ordered_pkg/

View files and strucure of package::

    ls
    ls -laR data/

Make a workspace directory::

    mkdir workspace

Scripts
-------

Run the following scripts in order.

1 - Create technical metadata for all content files with file order included::

    import-object --workspace ./workspace data/audio/audio_wav_1.wav --order 1
    import-object --workspace ./workspace data/audio/audio_wav_2.wav --order 2
    import-object --workspace ./workspace data/audio/audio_wav_3.wav --order 3
    import-object --workspace ./workspace data/audio/audio_wav_4.wav --order 4
    import-object --workspace ./workspace data/audio/audio_wav_5.wav --order 5
    import-object --workspace ./workspace data/dataset/text_file_1.txt --order 1
    import-object --workspace ./workspace data/dataset/text_file_2.txt --order 2
    import-object --workspace ./workspace data/dataset/text_file_3.txt --order 3
    import-object --workspace ./workspace data/dataset/text_file_4.txt --order 4
    import-object --workspace ./workspace data/dataset/text_file_5.txt --order 5

2 - Create digital provenance data for the package creation::

    premis-event creation '2019-11-21T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP from a structured data package' --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

3 - Create digital provenance data for the audio data normalization event::

    premis-event migration '2019-09-20T13:30:55' --workspace ./workspace --event_detail 'Normalization of audio file formats from Apple ProRes to WAVE' --event_outcome success --event_outcome_detail 'WAVE files created' --agent_name 'ffmpeg' --agent_type software --event_target data/audio

4 - Create digital provenance data for the dataset compilation and migration::

    premis-event migration '2019-08-20T13:30:55' --workspace ./workspace --event_detail 'Migration of data from format X to format Y' --event_outcome success --event_outcome_detail 'Dataset migrated' --agent_name 'MS Office' --agent_type software --event_target data/dataset

5 - Create digital provenance data for fixing one broken file before pre-ingest::

    premis-event migration '2019-10-10T13:30:55' --workspace ./workspace --event_detail 'File contained some embarassing errors that were fixed during the pre-ingest quality check' --event_outcome success --event_outcome_detail 'Contents fixed and file is now valid' --agent_name 'vim' --agent_type software --event_target data/dataset/text_file_2.txt

6 - Create digital provenance data for checksum calculation::

    premis-event 'message digest calculation' '2019-11-21T13:30:55' --workspace ./workspace --event_detail 'Calculating the MD5 checksum of the digital objects' --event_outcome success --event_outcome_detail 'MD5 checksum successfully calculated for all digital objects in the package' --agent_name 'Pre-Ingest tool' --agent_type software

7 - Wrap the descriptive metadata into METS XML wrapper files, one for each content type::

    import-description metadata/metadata_sound_dc.xml --workspace ./workspace --remove_root --dmdsec_target data/audio
    import-description metadata/metadata_dataset_dc.xml --workspace ./workspace --remove_root --dmdsec_target data/dataset

8 -  Compile the structural map and create the file section::

    compile-structmap --workspace ./workspace 

9 - Compile the METS document and copy content files to the workspace (feel free
to change the name of the organization)::

    compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

10 - Digitally sign the METS document::

    sign-mets --workspace ./workspace ../../cert/rsa-keys.crt

11 - Compress the workspace contents to a SIP archive in tar format::

    compress --tar_filename test-set5.tar ./workspace

Evaluation
----------

List the contents of the workspace::

    ls -laR workspace/

| Do the files ``mets.xml`` and ``signature.sig`` exist in the workspace?
| What does the ``contents/`` folder contain?

List the contents of the tar archive::

    tar -tvf workspace/test-set5.tar

Does the created tar archive contain all the files in the workspace?

View the created METS document::

    gedit workspace/mets.xml

|
| The descriptive metadata is just below the mets header, in the descriptive metadata section (``dmdSec``). There should be two different dmdSec blocks, one describing the audio contents, and the other describing the textual contents.
|
| The METS structural map (``structMap``) is at the end of the document. Look at the described structure. There should be links to the created provenance data for both the whole package at the root of the structural map as well as for the different sections of the structural map. The descriptive metadata should also be linked separately to both sections.
|
| Take a look at the file section (``fileSec``) just above the structural map. Can you see the one fixed file with multiple ``ADMID`` attributes linking to both the technical as well as the provenance metadata.
| 
|

Finally, clean up the workspace::

    rm -rf workspace/*
