Exercise 7 - scripting and automating the metadata generation
=============================================================

In this exercise, you should focus on integrating the pre-ingest tool to your needs.
This exercise covers ideas for scripting and automating the use of the tool.

The example script
------------------

The workshop training materials include a basic shell script example that can run the commands for creating a SIP from a folder containing digital objects. The script will run all mandatory commands, including creating technical metadata for image, audio and video files. The script does not include any error handling or advanced functions such as ordered structural metadata.

Make a workspace directory::

    mkdir workspace

Open the shell script for documentation on how the script is run.

Run the shell script for one test case folder(e.g. the AV-package)::

     ./pre_ingest_simple.sh ../test_data/av_pkg/data/ workspace/ ../test_data/av_pkg/metadata_dc.xml ../test_data/cert/rsa-keys.crt test.tar


Evaluation
----------

Did the script run properly and are there contents in the workspace folder?

View the created METS document::

    gedit workspace/mets.xml

Does it look alright? Is all metadata in place?

Integrating the tool
--------------------

Write down, on a piece of paper or on the computer, ideas for how you would use the tool and how it could be integrated into your organization.

1 - Where are the digital objects? How much reorganizing does it require before the digital objects are in such a shape (e.g. folders) that you can run the pre-ingest tool to create SIPs?

2 - Where is the descriptive metadata? How do you get the content descriptions into XML files that can be integrated into the SIP by the pre-ingest tool?

3 - Do you have a system that administrates the contents and the metadata that could integrate the tool for automated SIP creation?

4 - If you do not have a system, how would you run the scripts? What kind of automated scripts do you need? Can the example script in this repository be modified for your needs?

5 - How do you manage the SIPs? Where and how do you keep track of what has been ingested into the digital preservation system and when?

6 - Do you have advanced needs (e.g. structural metadata, provenance information) that are not supported by the pre-ingest tool?
