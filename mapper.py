#!/usr/bin/env python

import sys

# input comes from STDIN (standard input)

def is_number(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

for line in sys.stdin:
    line = line.strip()
    words = line.split(',')
    if is_number(words[1]):
        ID = words[1]
        print '\t'.join((ID,'1','1'))
    else:
        if (int(words[3]) == 5):
            ID = words[0]
            name = words[1]
            print '\t'.join((ID,'0', name))

