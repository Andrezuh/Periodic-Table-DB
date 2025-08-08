#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  
  if [[ $1 =~ ^[0-9]$ ]]
  then
    echo This is a positive integer
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then
    echo This is a one or two lettered text
  else
    echo Another input was inserted
  fi

fi