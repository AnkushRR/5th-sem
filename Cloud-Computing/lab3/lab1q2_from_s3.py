'''
Author: SaiKumar Immadi
5th Semester @ IIIT Guwahati
'''

# You can use this code for free. Just don't plagiarise it for your lab assignments

import boto

def readFile(filename):
	words=[]
	for lineInFile in filename:
		for wordInLine in lineInFile.split():
			words.append(wordInLine)
	return words

def wordCount(words):
	wordCountDict={}
	for word in words:
		if word in wordCountDict:
			wordCountDict[word]+=1
		else:
			wordCountDict[word]=1
	return wordCountDict

def topTenWords(dictionary,stopList):
	dictList=list(dictionary)
	updDictList=list(set(dictList)-set(stopList))
	topUsedWords=[]
	for index1 in range(0,10):
		topWord=updDictList[0]
		topCount=dictionary[updDictList[0]]
		for index2 in range(0,len(updDictList)):
			if dictionary[updDictList[index2]]>topCount:
				topWord=updDictList[index2]
				topCount=dictionary[updDictList[index2]]
		topUsedWords.append([topWord,topCount])
		updDictList.remove(topWord)
	return topUsedWords

def Main():
	s3=boto.connect_s3()
	key=s3.get_bucket('mediahappytraveller').get_key('files/simple_textfile.txt')
	print "Key retrieved from s3"
	key.get_contents_to_filename('textfile.txt')
	print "File downloaded to local machine from s3"
	textFile=open('textfile.txt','r')
	contents=readFile(textFile)
	wordCountDictionary=wordCount(contents)
	stopList=["a","an","the","is","am","are","in","ut","ad"]
	#stopList=["a","an","the","is","am","are","in"]
	topUsedWords=topTenWords(wordCountDictionary,stopList)
	print "The top used words are : "
	print topUsedWords
if __name__=="__main__":
	Main()