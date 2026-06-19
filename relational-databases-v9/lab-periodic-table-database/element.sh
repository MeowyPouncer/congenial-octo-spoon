#!/bin/bash

PSQL=(psql periodic_table freecodecamp -t --no-align)



if [[ ! $1 ]]; then 
  printf '%s\n' "Please provide an element as an argument."
fi

IFS="|"

if [[ $1 =~ ^[0-9]+$ ]]
  then
    query="SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties JOIN elements USING (atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1"
elif [[ $1 =~ ^[a-zA-Z]+$ ]]
  then
    query="SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties JOIN elements USING (atomic_number) JOIN types USING(type_id) WHERE symbol ILIKE '$1' OR name='$1'"
fi

result="$("${PSQL[@]}" -c "$query")"

if [[ ! -z $result ]]
  then 
    read atomic_number name symbol type atomic_mass melting_point boiling_point <<< $result
    printf '%s\n' "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
  elif [[ $1 ]] 
    then
      printf '%s\n' "I could not find that element in the database."  
fi

