#!/usr/bin/env python

from operator import itemgetter
import sys

def reducer():
    lastID = ""
    count = 0
    name = ""
    for line in sys.stdin:
        try:
            if line.strip()=="":
                continue
            fields = line.split("\t")
            ID = fields[0]
            tag = fields[1]
        except:
            print "Reading Error"

        try:
            if ID != lastID:
                if tag == '0':
                    if count > 0:
                        print ','.join((lastID, name, str(count)))
                    name = fields[2]
                else:
                    name = ""
                count = 0
            elif ID == lastID:
                if tag == '1':
                    if len(name) > 0:
                        count += 1
            lastID = ID
        except:
            print "Accumulative Error"
    if count > 0 and len(name) > 0:
        print ','.join((lastID, name, str(count)))

if __name__=='__main__':
    reducer()
