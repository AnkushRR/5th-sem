#!/usr/bin/python
import sys
oldKey=None
totalValue=0

for line in sys.stdin:
	data=line.strip().split('\t')
	if(len(data)!=2):
		continue
	thisKey,thisValue=data
	if oldKey and oldKey!=thisKey:
		print "{0}\t{1}".format(oldKey,totalValue)
		totalValue=0
	oldKey=thisKey
	totalValue+=float(thisValue)
if oldKey:
	print "{0}\t{1}".format(oldKey,totalValue)

