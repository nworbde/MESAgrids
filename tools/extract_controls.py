#!/usr/bin/env python

import re
import argparse

parser = argparse.ArgumentParser(description="reads a list of variable declarations and strips off everything to the left of the '::'.  This is useful for generating default listings and namelists")

parser.add_argument('-e','--add-equals',help='append equals sign to variable name',default=False,action='store_true')
parser.add_argument('input_file',type=str,help='file containing variable definitions')

var = re.compile(r'::\s+(\w+)')

args = parser.parse_args()

if args.add_equals:
    eq = " = "
else:
    eq = ''

controls_file = args.input_file
    
with open(controls_file,'r') as f:
    for line in f:
        m = var.search(line)
        if m:
            print '    {0}{1}'.format(m.group(1),eq)

