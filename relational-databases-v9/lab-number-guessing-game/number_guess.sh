#!/bin/bash
PSQL=(psql number_guess freecodecamp -t --no-align)

printf '%s\n' "Enter your username:"
read username

query="SELECT count(game_id), MIN(number_of_guesses) FROM games WHERE username='$username'"
result="$("${PSQL[@]}" -c "$query")"

IFS="|" read -r games_amount best_guess <<< "$result"


if (( games_amount == 0 )); then
  printf 'Welcome, %s! It looks like this is your first time here.\n' "$username"
else
  printf 'Welcome back, %s! You have played %s games, and your best game took %s guesses.\n' "$username" "$games_amount" "$best_guess"
fi

printf '%s\n' "Guess the secret number between 1 and 1000:"
number=$(( RANDOM % 1000 + 1 ))

while true
do
  read user_guess

  if [[ ! "$user_guess" =~ ^[0-9]+$ ]]; then
    printf '%s\n' "That is not an integer, guess again:"
    continue
  fi

  (( number_of_guesses++ ))

  if (( user_guess < number )); then
    printf '%s\n' "It's higher than that, guess again:"
  elif (( user_guess > number )); then
    printf '%s\n' "It's lower than that, guess again:"
  else
    query="INSERT INTO games(username, number_of_guesses) VALUES('$username', $number_of_guesses)"
    "${PSQL[@]}" -c "$query" > /dev/null
    break
  fi
done

printf '%s\n' "You guessed it in $number_of_guesses tries. The secret number was $number. Nice job!"
