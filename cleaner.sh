#!/usr/bin/env bash

echo "Cleaner is ready for Cleaning"
echo "_________________________________________"

sudo apt-get remove && sudo apt-get clean && sudo apt-get autoremove && sudo apt-get autoclean

echo "_________________________________________"
echo "Junk is out of the system"
