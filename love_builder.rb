#!/usr/bin/env ruby

# redefining of fail for slightly more friendly messaging
def fail(msg, code = 1)
    print "Error: #{msg}#{msg.end_with?("\n") ? '' : "\n"}"
    exit code
end

def archive(name)
    file = name
    file += '.love' unless file.end_with? '.love'
    print "Archiving...\n"
    `zip -r #{file} *`
    
    if $?.exitstatus == 0
        print "#{name}.love created successfully.\n"
    else
        fail "An error occurred file creating the file.\n"
    end
end

def merge
    fail "Please provide a executable location.\n" unless ARGV.length == 2
    fail "The location you specified for the executable does not exist. (#{ARGV[1]})\n" unless File.exists? ARGV[1]
    archive('temp')
    print "Merging...\n"
    
    if ARGV[1].end_with? '.app'
        name = File.basename(ARGV[1], '.app')
        `cat #{ARGV[1]}/Contents/MacOS/love temp.love > #{ARGV[1]}/Contents/MacOS/temp`
        File.rename("#{ARGV[1]}/Contents/MacOS/temp", "#{ARGV[1]}/Contents/MacOS/love")
        print "Making file executable...\n"
        `chmod a+x #{ARGV[1]}/Contents/MacOS/love`
    else
        `cat #{ARGV[1]} temp.love > temp`
        File.rename('temp', ARGV[1])
        print "Making file executable...\n"
        `chmod a+x #{ARGV[1]}`
    end
    
    fail "Merge was unsuccessful.\n" if $?.exitstatus != 0
    print "Deleting temp.love...\n"
    File.delete('temp.love')
    print "Merged executable created successfully.\n"
end

if ARGV.length == 0
    print "Usage: ./love_builder.rb [archive|merge]\n"
    print "Make sure you are in the project folder when using this program.\n"
    print "\n"
    print "archive:\n"
    print "\tUsage: ./love_builder.rb [archive] love_file_location\n"
    print "\tThis builds a .love file, and is the default command.\n"
    print "\n"
    print "\tlove_file_location - The location where you want the .love to be put. (Having a .love extension for this path is optional)\n"
    print "\n"
    print "merge:\n"
    print "\tUsage ./love_builder.rb merge executable_location\n"
    print "\tThis creates a merged executable (on Mac this will be a .app file).\n"
    print "\n"
    print "\texecutable_location - The location of a copy of the love.app/love executable which can be used for your game. If you want to create Mac version you must end the path with the .app extension.\n"
    exit 1
end

fail "Directory does not contain a main.lua file.\n" unless File.exists? 'main.lua'

if ARGV[0] == 'archive' or ARGV[0] != 'merge'
    if ARGV[0] == 'archive' and ARGV[1]
        archive(ARGV[1])
    elsif ARGV[0]
        archive(ARGV[0])
    else
        print "Please give a name for the .love file.\n"
        exit 1
    end
elsif ARGV[0] == 'merge'
    merge
end