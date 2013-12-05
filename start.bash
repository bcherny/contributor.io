#!/bin/bash -x

clear

supervisor -w . --debug server &

node-inspector -w *.js server &