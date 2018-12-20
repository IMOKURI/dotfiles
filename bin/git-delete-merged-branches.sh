#!/usr/bin/env bash

git branch --merged | grep -vE '^\*| master$| develop$' | xargs git branch -d
