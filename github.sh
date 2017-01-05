#! /bin/bash

#First, check if this if the git repo is ready
case $(ps -o stat= -p $$) in
  *+*) 
		echo "Running in foreground" 
		echo "please let the program run in background"
		exit
		;;
esac

if [ ! -d .git ]
	then
		echo "this is not a valid git repo"
		echo "Please initiate it before attempting to sync with Dropbox"
		exit
fi

#Check if it has a valid origin
if [[ ! 'git remote' ]]
	then
		echo "this git repo does not have a valid remote branch"
		echo "Please add the remote branch"
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
while :
do
	if [[ 'git status --porcelain' ]]
		then
			git add -A &> /dev/null
			git commit -m "$current_date" &> /dev/null
			git push origin master &> /dev/null
	fi
	sleep $refresh_time
done


