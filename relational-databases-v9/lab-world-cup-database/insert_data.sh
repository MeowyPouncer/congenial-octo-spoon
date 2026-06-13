#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


# create array to store seen teams

declare -A seen


# function to check if array 'seen' contains 'team' key

add_team_to_db () {
  local team="$1"
  if [[ -z "${seen[$team]}" ]]
    then
      # if not, create the key and insert team to the database

      seen["$team"]=1
      $PSQL "INSERT INTO teams(name) SELECT '$1' ON CONFLICT DO NOTHING"
  fi

}


# add games and teams
{
read header
while IFS="," read year round winner opponent winner_goals opponent_goals
do

add_team_to_db "$winner"
add_team_to_db "$opponent"

$PSQL "

INSERT INTO 
games(

  year,
  round, 
  winner_id, 
  opponent_id, 
  winner_goals, 
  opponent_goals

)
VALUES (

  $year, 
  '$round', 
    (
    SELECT team_id FROM teams WHERE name='$winner'
    ), 
    (
    SELECT team_id FROM teams WHERE name='$opponent'
    ), 
  $winner_goals, 
  $opponent_goals

)
"

done
} < games.csv



# those weren't accepted by testing script. they're cool tho.
: '
echo -e "$(psql --username=freecodecamp --dbname=worldcup<<'SQL'

BEGIN;

CREATE TEMP TABLE staging_games (
year INT,
round VARCHAR(40),
winner VARCHAR(50),
opponent VARCHAR(50),
winner_goals INT,
opponents_goals INT
) ON COMMIT DROP;

\copy staging_games(year, round, winner, opponent, winner_goals, opponents_goals) FROM 'games.csv' WITH (FORMAT csv, HEADER true);


INSERT INTO teams(name) SELECT DISTINCT name FROM staging_games sg
CROSS JOIN LATERAL(
VALUES
(sg.winner),
(sg.opponent)
) 
team(name)
ON CONFLICT (name) 
DO NOTHING
;
COMMIT;
SQL
)"
'