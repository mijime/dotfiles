#!/bin/bash

for bash_completion in ~/.bashrc
do
  if [[ -f ${bash_completion} ]]
  then source ${bash_completion}
  fi
done
