Pre-Ingest Tool Training Workshop
=================================

This repository contains test data sets and exercises with command examples for the pre-ingest tool training exercises held at CSC.

Installation of the pre-ingest tool
-----------------------------------

Start by creating a folder for all workshop data::

    mkdir training-workshop
    cd training-workshop/

Then clone this repository to the folder::

    git clone https://github.com/Digital-Preservation-Finland/siptools-workshop-2019

Then, do the following commands in order::

    git clone https://github.com/Digital-Preservation-Finland/dpres-siptools
    cd dpres-siptools
    virtualenv venv
    source venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements_github.txt
    pip install .
    pip install git+https://github.com/Digital-Preservation-Finland/dpres-ipt
    export PYTHONIOENCODING=utf8
    cd ..
    cd siptools-workshop-2019/

Exercises
---------

Open the exercise instructions in the ``exercises`` folder for the specific exercises. You can open the exercise instruction .rst files with your web browser. There are curently seven exercises, that contain command line examples that can be run and an evaluation section where you can evaluate the output from the exercise.
