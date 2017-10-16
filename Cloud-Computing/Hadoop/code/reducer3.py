#!/usr/bin/python

import sys
oldKey=None
highestValue=0
for line in sys.stdin:
	data=line.strip().split('\t')
	if len(data)!=2:
		continue
	thisKey,thisValue=data
	if oldKey and oldKey!=thisKey:
		print "{0}\t{1}".format(oldKey,highestValue)
		highestValue=0
	oldKey=thisKey
	if float(thisValue)>=highestValue:
		highestValue=float(thisValue)
if oldKey:
	print "{0}\t{1}".format(oldKey,highestValue)

