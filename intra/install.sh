#!/bin/bash

echo "$(git rev-parse --show-toplevel)"' installation !'

VENV_PATH='.venv'

rm -rf ${VENV_PATH}
python3 -m venv ${VENV_PATH}
source "${VENV_PATH}/bin/activate"
pip install update
pip install -r requirements.txt

echo 'To use the software do:'
echo "source ${VENV_PATH}/bin/activate"
