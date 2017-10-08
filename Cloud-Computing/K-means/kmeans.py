#!/bin/usr/python
import sys
from math import sqrt
from random import randint

def main(argv):
	if len(argv)!=2:
		print "The Format is <kmeans.py K data.txt>"
		return 0
	k=int(argv[0])
	if(k<1):
		print "The Format is <kmeans.py K data.txt>"
		print "K value should be greater than 0"
		return 0
	filename=argv[1]
	file=open(filename,"r")
	mainList=[]
	for line in file:
		lineStripped=line.strip().split('\t')
		mainList.append((float(lineStripped[0]),float(lineStripped[1])))
	oldKlists=[]
	klists=[]
	tempMainMeanFindingList=list(mainList)
	kmeans=[]
	oldKmeans=[]
	for i in range(0,k):
		rand=randint(0,len(tempMainMeanFindingList))
		randPoint=tempMainMeanFindingList[rand]
		kmeans.append(randPoint)
		tempMainMeanFindingList[:] = (value for value in tempMainMeanFindingList if value != randPoint)

	for i in range(0,k):
		klists.append([])

	# tempListSize=len(mainList)/k
	# for i in range(0,k-1):
	# 	klists[i]=mainList[(i)*tempListSize:(i+1)*tempListSize]
	# klists[k-1]=mainList[(k-1)*tempListSize:]


	# kmeans=calculateKmeans(mainList,klists,kmeans)
	iterations=0
	maxIterations=100000
	while((cmp(oldKmeans,kmeans)!=0 or cmp(oldKlists,klists)!=0) and iterations<maxIterations):
		oldKmeans=list(kmeans)
		oldKlists=list(klists)
		#calculating clusters
		klists=[]
		for i in range(0,k):
			klists.append([])
		klists=calculateKlists(mainList,klists,kmeans)
		print len(klists[0]),len(klists[1]),len(klists[2])
		#calculating centroids of clusters
		kmeans=[]
		kmeans=calculateKmeans(mainList,klists,kmeans)

		iterations+=1

	print "The K-means are"
	for i in range(0,k):
		print "( %.4f," % kmeans[i][0], "%.4f" % kmeans[i][1],")"

	return 0



def calculateKmeans(mainList,klists,kmeans):
	#Empty kmeans set is passed to this function
	#kmeans is [] for any k
	xtotal=0.0
	ytotal=0.0
	for i in range(0,len(klists)):
		for j in range(0,len(klists[i])):
			xtotal+=klists[i][j][0]
			ytotal+=klists[i][j][1]
		kmeans.append((xtotal/(len(klists[i])*1.0),ytotal/(len(klists[i])*1.0)))
	return kmeans
def calculateKlists(mainList,klists,kmeans):
	#Empty klists set of sets is passed to this function
	#klists is [[],[],[]] for k=3
	mainListSize=len(mainList)
	tempMainList=list(mainList)
	for i in range(0,mainListSize):
		tempPoint=tempMainList.pop(-1)
		tempList=[]
		for j in range(0,len(klists)):
			x1=kmeans[j][0]
			y1=kmeans[j][1]
			x2=tempPoint[0]
			y2=tempPoint[1]
			dist = sqrt((x2 - x1)**2 + (y2 - y1)**2)
			tempList.append(dist)
		klists[tempList.index(min(tempList))].append(tempPoint)
		# print str(tempList)
	return klists


if __name__ == "__main__":
   main(sys.argv[1:])
