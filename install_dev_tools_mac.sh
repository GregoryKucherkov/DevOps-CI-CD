#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail


LOG_FILE="install.log"


# check existance
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# log function
log() {
    local msg="$1"

    echo "$msg" | tee -a "$LOG_FILE"
}

# PACKAGES=("Docker"  "Docker Compose"  "Python" "Django" )

# 1) Check if Docker is installed
if command_exists docker; then
  log "Docker is already installed." 
else
  log "Docker is not installed! Installing Docker..." 
  brew install --cask docker

  log "Docker installed successfully." 
  echo "⚠ Please open Docker Desktop manually once to complete setup."
fi


# 2) Check Docker Compose
if command_exists docker-compose; then
    log "Docker Compose is already installed." 
else
    log "Docker Compose is not installed! Installing Docker Compose..." 
    brew install docker-compose
    log "Docker Compose installed successfully." 
fi



# 3) Check if Python is installed
if command_exists python3; then
    CURRENT_VERSION=$(python3 -V 2>&1 | awk '{print $2}')

    CURRENT_MAJOR=$(echo "$CURRENT_VERSION" | cut -d. -f1) 
    CURRENT_MINOR=$(echo "$CURRENT_VERSION" | cut -d. -f2)
    if (( CURRENT_MAJOR < 3 || (CURRENT_MAJOR == 3 && CURRENT_MINOR < 9) )); then
        echo "Python needs upgrade"
        brew upgrade python3
        log "Latest python installed" 
    else
        log "Python is already installed. Version $CURRENT_VERSION" 
    fi

else
  log "Python is not installed! Installing Python..." 
  brew install python3

  log "Python installed successfully." 
fi



# 4) Pip check
if command_exists pip3; then
    log "Pip is already installed." 
else
    log "Pip is not installed! Installing Pip..." 
    python3 -m ensurepip --upgrade
    log "Pip installed successfully." 
fi

#  virtual env install, otherwise we need brew install for packages

VENV_DIR="env"

if [ ! -d "$VENV_DIR" ]; then
    log "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi 

source "$VENV_DIR/bin/activate"
python -m pip install --upgrade pip



# 5) Django check
if python3 -m pip show django >/dev/null 2>&1; then
    log "Django is already installed." 

else
    log "Django is not installed! Installing Django..." 
    python3 -m pip install Django
    log "Django installed successfully." 
fi

echo "To start using the virtual environment, run: source env/bin/activate"