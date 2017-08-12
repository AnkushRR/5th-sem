'''
Author: SaiKumar Immadi
Sentiment Extractor in Python for Cloud Computing Lab 2
5th Semester @ IIIT Guwahati
'''

# You can use this code for free. Just don't plagiarise it for your lab assignments

import sys
import ast
SentimentLexiconFile=open("SentimentLexicon.txt","r")
SentimentLexicon={}
for WordSentiment in SentimentLexiconFile:
	temp_list=WordSentiment.split()
	SentimentValue=ast.literal_eval(temp_list[-1])
	temp_list=temp_list[:-1]
	SentimentWord=' '.join(temp_list)
	SentimentLexicon[SentimentWord]=SentimentValue
#sentiment_lexicon={"happy":4,"sad":-4,"awesome":5,"fanatstic":5,"super":3,"angry":-3,"cry":-5,"laugh":5,"smile":2,"negative":-1,"simple":0}              
SentenseWords=sys.argv[1:][0].split()
sentiment=0
for word in SentenseWords:
	if word in SentimentLexicon:
		sentiment+=SentimentLexicon[word]
	else:
		sentiment+=0
print "The sentiment of the sentence",sys.argv[1:][0],"is",sentiment
#python Setiment.py "angry cry laugh hate smile"