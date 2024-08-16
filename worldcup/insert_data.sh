#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS; do
if [[ $YEAR != year ]]; then
# get winner
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  # if not found
  if [[ -z $WINNER_ID ]]; then
    #  insert team winner
    INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_RESULT == 'INSERT 0 1' ]]; then
        echo inserted into teams $WINNER
      fi
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  fi
# get opponent
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  # if not found
  if [[ -z $OPPONENT_ID ]]; then
    #  insert team opponent
    INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT == 'INSERT 0 1' ]]; then
        echo inserted into teams $OPPONENT
      fi
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals,opponent_goals, winner_id, opponent_id) VALUES($YEAR, '$ROUND', $WINNERGOALS, $OPPONENTGOALS, $WINNER_ID, $OPPONENT_ID)")
  if [[ $INSERT_GAME_RESULT == 'INSERT 0 1' ]]; then
    echo inserted into games $WINNER beat $OPPONENT by $WINNERGOALS TO $OPPONENTGOALS
  fi
fi
done
