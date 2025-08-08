#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  
  OUTPUT_INFO() {
    if [[ -z $1 ]]
    then
      echo I could not find that element in the database.
    else
      echo I found a match in the database: $1
    fi
  }

  if [[ $1 =~ ^[0-9]$ ]]
  then
    QUERY_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM ELEMENTS WHERE atomic_number=$1")
    OUTPUT_INFO "$QUERY_ATOMIC_NUMBER"

  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then
    QUERY_SYMBOL=$($PSQL "SELECT atomic_number FROM ELEMENTS WHERE symbol='$1'")
    OUTPUT_INFO "$QUERY_SYMBOL"

  else
    QUERY_NAME=$($PSQL "SELECT atomic_number FROM ELEMENTS WHERE name='$1'")
    OUTPUT_INFO "$QUERY_NAME"

  fi

fi