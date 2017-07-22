#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    pyenv install 2.7.10
    pyenv virtualenv 2.7.10 conan
    pyenv rehash
    pyenv activate conan
fi

sudo -H pip install --upgrade pip
sudo -H pip install conan --upgrade
sudo -H pip install conan_package_tools

conan remote add upload_repo "https://api.bintray.com/conan/bitprim/secp256k1"
conan user
