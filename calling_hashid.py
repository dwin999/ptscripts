"""
Example of how to use hashid within another python script, my use was for an irc bot
"""
import hashid
import sys, StringIO
hash = '9cdfb439c7876e703e307864c9167a15' #hash we want to id
sys.argv = ['lol','-jm', hash]
old_stdout = sys.stdout
capturer = StringIO.StringIO()
sys.stdout = capturer
hashid.main()
sys.stdout = old_stdout
hashid_output = capturer.getvalue()
print hashid_output
