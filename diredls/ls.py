#!/usr/bin/env python
import os, sys

#print sys.argv[1]

#todo:what if user used -Q, or one of the other quoting formats? can we deal with that? im sure we can!
cmd = "ls -l -a -R" + " -Q"
diredcmd = cmd + " -l --dired"


rawdired = os.popen(diredcmd).read()
rawls = os.popen(cmd).read()
dired = rawdired.splitlines()
#print dired

assert dired[-1].startswith("//DIRED-OPTIONS//")

if dired[-2].startswith("//SUBDIRED//"):
	diredline = dired[-3]
	subdired = dired[-2]
else:
	diredline = dired[-2]
	subdired = None
	assert diredline.startswith("//DIRED//")

#print diredline
nums = diredline.split()[1:]
#print nums
assert len(nums)%2 == 0

from itertools import islice, izip
pairs = list(izip(nums[::2], nums[1::2]))

if subdired != None:
	subnums = subdired.split()[1:]
#	print subnums
	subpairs = list(izip(subnums[::2], subnums[1::2]))
	pairs += subpairs
#print pairs

pairs = [(int(p[0]), int(p[1])) for p in pairs]
pairs = sorted(pairs, key=lambda x: x[0])

#print "pairs:",pairs

files = []
dirs = []

#print len(list(pairs))

for pair in pairs:
	s,e = pair
	f = rawdired[s:e]
	#todo: look from here backwards for "\n  d" or "\n  -", to tell dirs and files apart. 
	#if we want to handle files with newlines in names, we might try playing with the escaping parameters or be careful about quotes.
	#entries in the subdired list are always dirs
	print ">>>",f
	files.append(f)

print  "orig------------------------------------------"
print rawls
print  "orig------------------------------------------"
output = ""
start = 0
for f in files:
	pos = rawls.find(f)
	#print pos
	marked =  "<<file>>"+f+"<</file>>"
	output += rawls[start:pos] + marked
	tocut = pos+len(f)
	#start = pos + len(f)
	rawls = rawls[tocut:]
print output


