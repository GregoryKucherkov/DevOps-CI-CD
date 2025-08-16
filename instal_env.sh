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

VENV_DIR="env"

if [ ! -d "$VENV_DIR" ]; then
    log "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi 

source "$VENV_DIR/bin/activate"
python -m pip install --upgrade pip

#  Django check
if python3 -m pip show django >/dev/null 2>&1; then
    log "Django is already installed." 

else
    log "Django is not installed! Installing Django..." 
    python3 -m pip install Django
    log "Django installed successfully." 
fi

echo "To start using the virtual environment, run: source env/bin/activate"