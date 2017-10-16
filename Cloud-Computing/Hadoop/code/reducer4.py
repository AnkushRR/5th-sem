#!/usr/bin/python
import sys
totalNoSales=0
totalValue=0

for line in sys.stdin:
	data=line.strip().split('\t')
	if(len(data)!=2):
		continue
	thisKey,thisValue=data
	totalNoSales+=1
	totalValue+=float(thisValue)
print "{0}\t{1}".format("total_sales_number",totalNoSales)
print "{0}\t{1}".format("total_sales_value",totalValue)
