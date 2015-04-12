#!/bin/bash

set -x

trap 'trap_errors' ERR

trap_errors() {
    echo "Error occured, abort." >&2
    exi t 1
}

wget -qO- https://get.docker.com/ | sh
