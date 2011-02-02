This is a little script written in Ruby that helps [LÖVE](http://love2d.org) developers with creating .love files and merged executables on Mac and Linux.

Before executing this script, make sure you're in your project directory.

## Setup

On a Mac (you can most likely do this on Linux) you can edit your ~/.bash\_profile file to create an alias for the script. Open up ~/.bash\_profile in a text editor, with a command like this (for Mac):

    open -a TextEdit ~/.bash_profile

Then add this line:

    alias lovebuild="/path/to/where/you/put/the/script/love_builder.rb"
    
Now you'll be able to execute it like this:

    lovebuild
    
## .love Files

To create a .love file execute this command:

    lovebuild archive $location_for_love_file
    # or
    lovebuild $location_for_love_file
    
Replace $location\_for\_love\_file with where you want the .love placed. Adding a .love extension to this path is optional.

## Merged Executables

To create a merged executable, first create a copy of love.app or the love executable (depending on your OS) and copy it just outside your project directory. Rename the new executable to whatever you want. Making sure you're in your project directory, execute this command:

    lovebuild merge ../$copied_executable_name

Replace $copied\_executable\_name with whatever you named your executable. If the name you give ends with .app, the script will create a Mac app, otherwise it will create a Linux executable.