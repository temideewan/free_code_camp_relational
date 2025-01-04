#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

MAIN(){
if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument"
  exit
else 
  if [[ $1 =~ ^[0-9]+$ ]]
    then
    FOUND_ELEMENT=$($PSQL "SELECT symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1")
  else
  SEARCH_STRING=$1
  STRING_LENGTH=${#SEARCH_STRING}
    if [[ $STRING_LENGTH > 2 ]]
    then
      FOUND_ELEMENT=$($PSQL "SELECT symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE name='$1'")
    else
      FOUND_ELEMENT=$($PSQL "SELECT symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1'")
    fi
  fi
fi
echo  "$FOUND_ELEMENT" | while read SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
do
  echo -e "$SYMBOL"
done
}
MAIN $1
