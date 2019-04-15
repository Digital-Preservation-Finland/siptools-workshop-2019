Pre-Ingest Tool Training in April 2019
======================================

This repository contains test data sets and command examples for the pre-ingest
tool training day held in April 2019 at CSC.

Installation of the pre-ingest tool
-----------------------------------

Do the following commands in order::

    git clone https://github.com/Digital-Preservation-Finland/dpres-siptools
    cd dpres-siptools
    virtualenv venv
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements_github.txt
    pip install .
    pip install git+https://github.com/Digital-Preservation-Finland/dpres-ipt
    cd ..

Test cases commands
-------------------

Open the test case .rst files for specific command instructions for each of the
six test cases, for example::

    gedit test-set1.rst
