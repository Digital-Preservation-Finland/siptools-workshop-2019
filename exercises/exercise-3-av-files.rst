Exercise 3 (Audio visual data contents)
=======================================

This test case consists of audio visual data contents. Audio data streams
require AudioMD metadata blocks as additional technical metadata while video
data streams require VideoMD metadata blocks.
The exercise focuses on creating mandatory technical metadata for audio visual contents.
In the evaluation the user is asked to evaluate the technical properties of the files by exploring the created techincal metadata.

Preparations
------------

Go to the test folder::

	cd test_data/av_pkg/

View the files and the structure of the package::

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

    create-audiomd data/audio_wav.wav --workspace ./workspace
    create-audiomd data/audio_mp3.mp3 --workspace ./workspace
    create-audiomd data/video_mp4.mp4 --workspace ./workspace

3 - Create VideoMD technical metadata for video streams (run once for each file
containing video stream data)::

    create-videomd data/video_mp4.mp4 --workspace ./workspace
    create-videomd data/video_ffv1.mkv --workspace ./workspace

4 - Create digital provenance data for the package (feel free to change the
event_detail and event_outcome_detail texts, or any other text for that
matter)::

	premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP for an AV data package' --event_target data/ --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

5 - Wrap the descriptive metadata into a METS XML wrapper file::

	import-description metadata_dc.xml --workspace ./workspace --remove_root

6 - Compile the structural map and create the file section::

	compile-structmap --workspace ./workspace 

7 - Compile the METS document and copy content files into the workspace (feel free
to change the organization name)::

	compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

8 - Digitally sign the METS document::

	sign-mets --workspace ./workspace ../../cert/rsa-keys.crt

9 - Compress the workspace contents into a SIP archive in tar format::

	compress --tar_filename test-set3.tar ./workspace

Evaluation
----------

List the contents of the tar archive::

	tar -tvf workspace/test-set3.tar

View the created METS document::

	gedit workspace/mets.xml

|
| Look at the created technical metadata blocks within the mets administrative metadata section (``amdSec``). The ``premis:object``, ``audiomd`` and ``videomd`` blocks describe the audio and video files' technical properties.
|
| Do all audio files have an audiomd block linked to it? Do all video files have a videomd block linked to it?
|
| What do the technical metadata blocks tell you about the files' technical properties?
| 
| Look at the file section (``fileSec``) just above the structural map. The video files should have separate stream elements within the file elements linking to the streams' technical metadata separate from the container files.
| 
|

Finally, clean up the workspace::

	rm -rf workspace/*
