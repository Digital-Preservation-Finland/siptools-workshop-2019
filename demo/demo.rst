Demonstration of commands
=========================

These are the commands used when demonstrating the pre-ingest tool during the workshop.

Commands
--------

Make a workspace directory::

    mkdir workspace

    import-object files/ --workspace ./workspace/

    ls -la workspace/

    premis-event creation '2019-04-16T13:30:55' --workspace ./workspace --event_detail 'Creating a SIP from a structured data package' --event_outcome success --event_outcome_detail 'SIP created successfully using the pre-ingest tool' --agent_name 'Pre-Ingest tool' --agent_type software

    ls -la workspace/

    import-description metadata/metadata.xml --workspace ./workspace --remove_root

    ls -la workspace/

    gedit workspace/<dmdsec>-dmdsec.xml

    compile-structmap --workspace ./workspace

    ls -la workspace/

    gedit workspace/md-references.xml

    compile-mets --workspace ./workspace ch 'my organization' 'e48a7051-2247-4d4d-ae90-44c8ee94daca' --copy_files --clean

    ls -la workspace/

    ls -la workspace/files/

    sign-mets --workspace ./workspace ../cert/rsa-keys.crt

    ls -la workspace/

    compress --tar_filename demo.tar ./workspace

    ls -la workspace/

    gedit workspace/mets.xml

    rm -rf workspace
