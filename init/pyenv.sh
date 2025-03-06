#!/bin/bash
set -euo pipefail

PYENV_VERSION=2.5.0
PYENV_ROOT=.pyenv

# https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable

trim() {
    local var="$*"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]\"]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]\"]}"}"
    printf '%s' "$var"
}

# create it at top level dir
ROOT_DIR=$(git rev-parse --show-toplevel)
pushd "${ROOT_DIR}"

# install pyenv
# skip if it already cloned
if [[ ! -d $PYENV_ROOT/.git ]]; then
    git clone --branch "v${PYENV_VERSION}" https://github.com/pyenv/pyenv.git $PYENV_ROOT
fi
# int pyenv env
export PYENV_ROOT
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# getting python version from Pipfile
PYTHON_VERSION=$(trim "$(grep python_version Pipfile | awk -F '=' '{print $2}')")

# install python
pyenv install -s "${PYTHON_VERSION}"
pyenv local "${PYTHON_VERSION}"
pyenv rehash

# install venv
python -m venv .venv --prompt "home-config-ansible"
source .venv/bin/activate
pip install -U pip
pip install pipenv
pipenv install

popd
