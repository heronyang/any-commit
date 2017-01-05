#! /bin/bash

#First, check if this is a valid git repo

if [ ! -d .git ]
	then
		echo "this is not a valid git repo"
		echo "Please initiate it before attempting to sync with Dropbox"
		exit
fi

#Then, we will set the refresh time of checking git status, default is 5 min 
args=("$@")
refresh_time=5
if [ -z "${args[0]}" ]
	then
		refresh_time=$(( refresh_time * 60 ))
	else
		refresh_time=$(( args[0] * 60 ))
fi

#Next, we will periodically check for the git status
current_date=$(date -u)
if [[ 'git status --porcelain' ]]
	then
		git add -A
		git commit -m "$current_date"
		git push origin master
fi


