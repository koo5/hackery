#!/usr/bin/env python2

#stuff
#python 2 btw

import json #like a baws
import urllib2
import sys, os


def name_search(s):
	##TODO
	f = urllib2.urlopen("https://api.github.com/search/repositories?q=" + s).read()
	x = json.loads(f) #at least you didnt see my fuck ups except for that one
	r = []
	for i,j in enumerate(x['items']):
		 r.append((i, j['full_name'])) #better save the git address here
	return r

def num_search(num):
	f = open("last_search", "r")
	g = json.load(f)
	for i in g:
		num = str(i[0])
		name = i[1]
		#print num, lookie, len(num), len(lookie), 
		if lookie == num:
			return name

"""two phase search, first enter text, get a list of numbered results, they are saved in last_results, then call this 
again with a number"""


if len(sys.argv) == 1:
	print "whatcha lookin at?"
else:
	lookie = sys.argv[1]

	if lookie.isdigit():
		name = num_search(lookie)
		if name == None:
			print "wat"
		else:
			cmd = "git clone https://github.com/"+name+".git"
			print name + " : " + cmd
			os.system(cmd)
	
	else:
		res = name_search(lookie)
		for i in res:
			print i

		#save it for later
		o = open("last_search", "w")
		json.dump(res, o, indent = 4)
		o.close()


