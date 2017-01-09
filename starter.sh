#!/bin/sh

# Installation (Git)
install_git_if_needed() {
    # Constants
    YUM_CMD=$(which yum)
    APT_GET_CMD=$(which apt-get)

    # Install git if needed
    git --version 2>&1 >/dev/null
    IS_GIT_AVAILABLE=$?
    if ! [ $IS_GIT_AVAILABLE -eq 0 ]; then
        echo "Installing git..."
        if [[ ! -z $YUM_CMD ]]; then
            sudo yum install -y git
        elif [[ ! -z $APT_GET_CMD ]]; then
            sudo apt-get install -y git
        else
            echo "error can't install git"
            exit 1;
        fi
        echo "Git is installed."
    fi
}

config_git_if_needed() {

    git_email=`git config --global user.email`
    if [ -z "$git_email" ] ; then
        read -r -p 'Please enter your email: ' var
        git config --global user.email "$var"
    fi

    git_name=`git config --global user.name`
    if [ -z "$git_name" ] ; then
        read -r -p 'Please enter your full name: ' var
        git config --global user.name "$var"
    fi

}

# Parse
show_help() {
    echo "$USAGE_TEXT" 1>&2; exit 1;
}

parse_option() {

    USAGE_TEXT="Usage: $0 [-f <string>] [-g <string>]
    -f, --folder        Local git repo path, ex: ~/repo/
    -g, --github        Github repo URL, ex: https://github.com/heronyang/dotfiles
    "

    while :; do
        case $1 in
            -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
                show_help
                exit
                ;;
            -f|--folder)       # Takes an option argument, ensuring it has been specified.
                if [ -n "$2" ]; then
                    folder=$2
                    shift
                else
                    printf 'ERROR: "--folder" requires a non-empty option argument.\n' >&2
                    exit 1
                fi
                ;;
            -g|--github)       # Takes an option argument, ensuring it has been specified.
                if [ -n "$2" ]; then
                    github=$2
                    shift
                else
                    printf 'ERROR: "--github" requires a non-empty option argument.\n' >&2
                    exit 1
                fi
                ;;
            --)              # End of all options.
                shift
                break
                ;;
            -?*)
                printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
                ;;
            *)               # Default case: If no more options then break out of the loop.
                break
        esac

        shift
    done

    if [ -z "${folder}" ] || [ -z "${github}" ]; then
        show_help
    fi

}

# Main
parse_option $@
install_git_if_needed
config_git_if_needed

# Further usage
echo "folder is $folder"
echo "github is $github"
