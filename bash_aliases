## Colorize the ls output ##
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la --color=auto'
 
## Show hidden files ##
alias l.='ls -d .* --color=auto'

## Apt-get ##
alias install='sudo apt-get install'
alias aget='sudo apt-get'

## a quick way to get out of current directory ##
alias u='cd ..'
alias uu='cd ../../'
alias uuu='cd ../../../'
alias uuuu='cd ../../../../'

## work work
alias work='cd ~/workspace'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3 | head -10'

# Build and Release a python module
alias build_release='python setup.py sdist bdist_wheel && /c/Users/Marin/AppData/Roaming/Python/Scripts/twine.exe upload dist/*'

## python and pip defaults to python3 and pip3
alias python=python3
alias pip=pip3


# Google App Engine
alias gae='python ~/workspace/google_appengine/dev_appserver.py --clear_datastore=yes'
alias deploy_reeview='python ~/workspace/google_appengine/appcfg.py --oauth2 update ~/workspace/reeviewit-master/'

# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi -f $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Attach to container
dattach() { docker exec -i -t $1 bash; }
