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

# Build and Release a python module on Windows
alias build_release='python setup.py sdist bdist_wheel && /c/Users/Marin/AppData/Roaming/Python/Scripts/twine.exe upload dist/*'

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

# Telepresence
telebackend() { docker build -f Dockerfile . -t nimble/backend-local && telepresence --swap-deployment backend --docker-run --rm -it -v $(pwd):/app nimble/backend-local python manage.py runserver 0.0.0:8080 --settings=settings.dev; }

# Common Directories
alias www='cd /var/www/'
alias a2='cd /etc/apache2/'

# Apache
alias logs='sudo multitail -cS apache /var/log/apache2/ssl_access.log -cS apache_error /var/log/apache2/error.log'

# PHP
alias phplogs='sudo multitail -cS apache --mergeall /var/www/rgbnotes/logs/*.log'

# Utilities
## View SSH connections
alias vssh='sudo lsof -i -n | egrep \<ssh\>'
