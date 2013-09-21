rgba-to-png
===========

*Feed it rgba and it spews images!*

Parse a source file (.css, .scss, etc..) for rgba color definitions and generates png images accordingly.


## Usage (command line)

There's two parameters: **path to the source file** and **path to images destination**.

Example:

    rgba-png path/to/file.css path/to/images/folder

It assumes that CSS rules are defined in their own line.

## Images

Images are named after the color properties, for example, the color below: 

    rgba(0, 252, 255, 0.8)
    
Will generate the following file:

    0-252-255-0_8.png
