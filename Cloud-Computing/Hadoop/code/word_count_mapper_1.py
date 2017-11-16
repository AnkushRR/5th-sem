#!/usr/bin/python
import sys
import re
for line in sys.stdin:
	refinedLine=re.sub("[^a-zA-Z]"," ",line)
	words=refinedLine.strip().split()
	for word in words:
		print "{0}\t{1}".format(word.lower(),"1")