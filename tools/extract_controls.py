#!/usr/bin/env python

import re
import argparse

parser = argparse.ArgumentParser(description="reads a list of variable declarations and strips off everything to the left of the '::'.  This is useful for generating default listings and namelists")

parser.add_argument('-e','--add-equals',help='append equals sign to variable name',default=False,action='store_true')
parser.add_argument('-a','--add-ampersand',help='append line continuation character',action='store_true',default=False)
parser.add_argument('-s','--add-store',help='write in form of an assign to a member of storage class',action='store_true',default=False)
parser.add_argument('input_file',type=str,help='file containing variable definitions')

var = re.compile(r'::\s+(\w+)')

args = parser.parse_args()
eq = ''
amp = ''

if (args.add_equals): eq = ' = '
if (args.add_ampersand): amp = ', &'

controls_file = args.input_file
varlist=[]
with open(controls_file,'r') as f:
    for line in f:
        m = var.search(line)
        if m:
            varlist.append(m.group(1))

for var in varlist:
    if args.add_store:
        print '    p% {0} = {0}'.format(var)
    else:
        print '    {0}{1}{2}'.format(var,eq,amp)
