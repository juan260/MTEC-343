# Documentation for the interpreter

## Purpose of this document
This document will serve as instructions for anyone who wants to execute THUMB.

## What is THUMB?
THUMB, meaning Twitter Hellspace Unstructured Music by BNO is an artistic project developed by Natalie Hogue, Alexander Wu and Juan Riera Gomez. The project explores our ideas of communication and our relationship with social media by synthesizing a soundscape from Twitter data.

## Instructions

THUMB is very easy to interpret, because the interpreter just has to start the program, and sit to listen while it runs on its own. It consists of two basic modules, one runs in SuperCollider and the other one runs in python. These two modules are meant to be executed on the same machine, and communicate through OSC protocol. It is assumed that the user has already downloaded the [code](https://github.com/Natameme/BNO_DNA), has Python3 and Super Collider installed and has a UNIX style terminal (this instructions have been tested on a Mac, so an OSX machine would be ideal)

### Python module
Run the following set of commands to install them all:
~~~
pip3 install python-osc
pip3 install twitter
pip3 install numpy
pip3 install nltk
python3
nltk.download('vader_lexicon')
exit()
~~~

From the code directory, the user just has to run:
~~~
python3 Main/TwitterScraping/main.py 
~~~



### SuperCollider module
There is a small setup that only needs to be done once:
* Open SuperCollider and run:
~~~
Platform.userExtensionDir;
~~~
* That directory returned by the command is where the SC stores the classes for the user. Copy the files located in '/Main/Classes' named 'Tonnetz.sc' and 'ChordFunc.sc' to that folder.

Now, once this has been done and the Python module is running, it's time to make it sound:
* Open SuperCollider IDE and open the file located in /Main/main.scd
* Follow the steps in the comments, starting with number 4 (Boot the server)
* Then 6 (load the functions). This step means running the big parenthesis.
* Then, at last, steps 7, 8 and 9 should make sound.

## Visual interface

This is up to the interpreter, but a suggestion would be to have the screen divided into the console output and the [twitter account feed](https://twitter.com/bno_thumb) where the program will be tweeting from time to time.

## How to stop THUMB

To stop THUMB open the terminal with the python module and press cmd + C multiple times, then open SC and press cmd + .