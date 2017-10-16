#!/usr/bin/python

import sys
for line in sys.stdin:
	data=line.strip().split('\t')
	if len(data)==6:
		date,time,store,category,cost,payment=data
		print "{0}\t{1}".format(category,cost)
