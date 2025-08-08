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
      ATOMIC_NUMBER=$1
      FINAL_QUERY=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius
      FROM elements
      INNER JOIN properties USING (atomic_number)
      INNER JOIN types USING (type_id)
      WHERE atomic_number=$ATOMIC_NUMBER")
      echo "$FINAL_QUERY" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."   
      done
      
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