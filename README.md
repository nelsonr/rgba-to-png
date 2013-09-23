rgba-png
===========

*Feed it rgba and it spews images!*

**rgba-png** is a command line tool to create PNG images from RGBA color definitions in stylesheets.

## Installation

    gem install rgba_png

## Usage (command line)

There's two parameters: **path to the source file** and **path to images destination**.

Example:

    rgba-png path/to/file.css path/to/images/folder

It assumes that CSS rules are defined in their own line.

## Images

Images are named after the color properties, for example, the color below: 

    rgba(0, 252, 255, 0.8)
    
Will generate the following file:

    0-252-255-0.8.png
