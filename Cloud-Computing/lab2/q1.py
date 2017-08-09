import sys
sentiment_lexicon={"happy":4,"sad":-4,"awesome":5,"fanatstic":5,"super":3,"angry":-3,"cry":-5,"laugh":5,"smile":2,"negative":-1,"simple":0}              
sentense_words=sys.argv[1:][0].split()
sentiment=0
for word in sentense_words:
	if word in sentiment_lexicon:
		sentiment+=sentiment_lexicon[word]
	else:
		sentiment+=0
print "The sentiment of the sentence",sys.argv[1:][0],"is",sentiment
#python q1.py "angry cry laugh hate smile awesome"