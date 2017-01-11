#AnyCommit
Making the cooperation between programmer and designer easier than you can imagine. It will auto-sync the local folder with github so that the designer won't worry about syncing with programmer's work.

# Deployed (Test) Platform
- Debian GNU/Linux 8 (jessie)

#File Description

1: `git-sync`: The main file which the user will run

2: `github.sh`: The bash script that runs in the background to auto-sync with the git remote.

#Install and Run

1: download or `git clone` the entire repo.

1: Run the script './git-sync -f --folder -l github-link -g --github-username'. It will run in background.

