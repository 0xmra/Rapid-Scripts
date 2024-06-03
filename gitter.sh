#!/usr/bin/env bash

git add * && git commit -v -s -am "$1" && git push && git status
