#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


export DEBIAN_FRONTEND=noninteractive
sudo yum update

LOG_FILE="install.log"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# log function
log() {
    local msg="$1"

    echo "$msg" | tee -a "$LOG_FILE"
}

# 1) Docker
if command_exists docker; then
  log "Docker is already installed."
else
  log "Docker is not installed! Installing Docker..."
  sudo yum install -y docker
  sudo systemctl start docker
  sudo systemctl enable docker
  log "Docker installed successfully."
fi

# 2) Docker Compose
if command_exists docker-compose; then
    log "Docker Compose is already installed."
else
    log "Docker Compose is not installed! Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    log "Docker Compose installed successfully."
fi

# 3) Python >= 3.9
REQUIRED_MAJOR=3
REQUIRED_MINOR=9

if command_exists python3; then
    CURRENT_VERSION=$(python3 -V 2>&1 | awk '{print $2}')

    MAJOR=${CURRENT_VERSION%%.*}
    MINOR=${CURRENT_VERSION#*.} 
    MINOR=${MINOR%%.*}  

    if (( MAJOR < REQUIRED_MAJOR || (MAJOR == REQUIRED_MAJOR && MINOR < REQUIRED_MINOR) )); then
        sudo yum install -y python3 python3-venv python3-pip
        log "Python upgraded successfully." 
    else
        log "Python is already installed. Version $CURRENT_VERSION" 
    fi
else
    log "Python is not installed! Installing Python..." 
    sudo yum install -y python3 python3-venv python3-pip
    log "Python installed successfully." 
fi

if [ ! -d "env" ]; then
    python3 -m venv env
fi
source env/bin/activate
python3 -m pip install --upgrade pip


# 4) Django check
if python3 -m pip show django >/dev/null 2>&1; then
    log "Django is already installed." 
else
    log "Django is not installed! Installing Django..." 
    python3 -m pip install Django
    log "Django installed successfully." 
fi


echo "To start using the virtual environment, run: source env/bin/activate"