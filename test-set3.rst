Test Case 3 (Audio visual data contents)
========================================

This test case consists of audio visual data contents. Audio data streams
require AudioMD metadata blocks as additional technical metadata while video
data streams require VideoMD metadata blocks.

Prepararations
--------------

Go to the test folder::

	cd test_data/av_pkg/

View files and strucure of package::

	ls
	ls data/

Make a workspace directory::

	mkdir workspace

Scripts
-------

Run the following scripts in order.

1 - Create technical metadata for all content files::

	import-object --workspace ./workspace data/

2 - Create AudioMD technical metadata for audio streams (run once for each
file containing audio stream data, that is for both audio and video files)::

    create-audiomd data/soundfile.wav --workspace ./workspace
    create-audiomd data/videofile.mp4 --workspace ./workspace

3 - Create VideoMD technical metadata for video streams (run once for each file
containing video stream data)::

    create-videomd data/videofile.mp4 --workspace ./workspace

4 - Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts)::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP for an AV data package' --event_target data/ --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

5 - Wrap the descriptive metadata into a METS XML wrapper file::

	import-description dc_description.xml --workspace ./workspace --remove_root

6 - Compile the structural map and create the file section::

	compile-structmap --workspace ./workspace 

7 - Compile the METS document and copy content files to the workspace (feel free
to change the organization name)::

	compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

8 - Digitally sign the METS document::

	sign-mets --workspace ./workspace ../../dpres-siptools/tests/data/rsa-keys.crt

9 - Compress the workspace contents to a SIP archive in tar format::

	compress --tar_filename sip.tar ./workspace

Evaluation
----------

List the contents of the tar archive::

	tar -tvf workspace/sip.tar

View the created METS document::

	gedit workspace/mets.xml

Look at the METS root element attributes, the CONTRACTID, the OBJID. Take a look at
the metsHdr containig information about the creating organization. The METS
structural map is at the end of the document, look at the descibed structure.

Take a closer look at the METS file section. Notice the links to both audioMD
and videoMD blocks for the files. Also note that the video file contains two
stream elements, one for the video stream, another for the audio stream.

Finally, clean up the workspace::

	rm -rf workspace/*
