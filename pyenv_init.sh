#!/bin/bash
set -euo pipefail

PYENV_VERSION=2.5.0

# https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable

trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]\"]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]\"]}"}"
    printf '%s' "$var"
}

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $SCRIPT_DIR

# install pyenv
if [[ ! -d .pyenv ]]; then
    git clone --branch "v${PYENV_VERSION}" https://github.com/pyenv/pyenv.git $SCRIPT_DIR/.pyenv
fi

export PYENV_ROOT=.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# getting python version from Pipfile
PYTHON_VERSION=$(trim $(grep python_version Pipfile | awk -F '=' '{print $2}'))
# install python
pyenv install -s $PYTHON_VERSION
pyenv local $PYTHON_VERSION

# install
python -m venv .venv --prompt "home-config-ansible"
source .venv/bin/activate
pip install -U pip pipenv
pipenv install
popd
