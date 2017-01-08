#! /bin/bash

#The first input is the local repo path
#The second input is the remote path 
#The third input is the refresh time, if it has, default is 5 min
args=("$@")
local_path=${args[0]}
remote_url=${args[1]}
refresh_time=5
#First, redirect to the local path and check if this if the git repo is ready
cd "${local_path}"
if [ ! -d .git ]
	then
		echo "this is not a valid git repo"
		echo "Trying to clone the repo"
		git clone "${remote_url}"
fi

#Check if it has a valid origin
#deprecated
#if [[ ! 'git remote' ]]
#	then
#		echo "this git repo does not have a valid remote branch"
#		echo "Please add the remote branch"
#		exit
#fi

#Then, we will set the refresh time of checking git status, default is 5 min 
if [ -z "${args[2]}" ]
	then
		refresh_time=$(( refresh_time * 60 ))
	else
		refresh_time=$(( args[2] * 60 ))
fi

#Next, we will periodically check for the git status
current_date=$(date -u)
while :
do
	git pull "${remote_url}"
	if [[ 'git status --porcelain' ]]
		then
			git add -A &> /dev/null
			git commit -m "$current_date" &> /dev/null
			git push "${remote_url}" &> /dev/null
	fi
	sleep $refresh_time
done


