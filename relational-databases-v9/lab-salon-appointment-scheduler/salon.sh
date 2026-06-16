#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
PSQL_ARR=(psql --username=freecodecamp --dbname=salon -t --no-align)


get_customer_id() {
  local query="SELECT customer_id FROM customers WHERE phone='$1'"
  local result="$($PSQL "$query")"
  if [[ -z $result ]]
    then
    :
    else
      CUSTOMER_ID="$result"
  fi
}

get_service_name_by_id(){
  local query="SELECT name FROM services WHERE service_id=$1"
  local result="$($PSQL "$query")"
  if [[ -z $result ]]
    then
    :
    else
      SERVICE_NAME="$result"
  fi
}

is_valid_service_number() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

get_existing_service_id() {
  local service_id="$1"
  local query="SELECT service_id FROM services WHERE service_id=$service_id"

  "${PSQL_ARR[@]}" -c "$query"
}


show_services_list() {
  local query="SELECT service_id, name FROM services ORDER BY service_id"
  local result="$($PSQL "$query")"
  echo "$result" | while IFS="|" read number service
  do
    echo "$number)" "$service"
  done
}

get_valid_appointment_choice() {
  while true
    do
      read SERVICE_ID_SELECTED

      if [[ "$SERVICE_ID_SELECTED" == 0 ]]
        then
          printf '%s\n' "Have a good day!"
          sleep 0.1s
          printf '%s\n' "Bye!"
          sleep 0.1s
          exit
      fi

      if ! is_valid_service_number "$SERVICE_ID_SELECTED"
        then
          printf '%s\n' "It is not a valid service number. Choose again, or press '0' to exit:"
          show_services_list
          continue
      fi

      SERVICE_ID_FOUND=$(get_existing_service_id "$SERVICE_ID_SELECTED")

      if [[ -n "$SERVICE_ID_FOUND" ]]
        then
          SERVICE_ID_SELECTED="$SERVICE_ID_FOUND"
          break
      fi

      printf '\n%s\n' "Can't find a service with such a number. Choose again, or press '0' to exit:"
      show_services_list
    done
}

process_customer() {

  printf '\n%s\n' "Please, enter your phone number." 
  read CUSTOMER_PHONE

  until [[ "$CUSTOMER_PHONE" =~ ^[0-9]+(-[0-9]+)*$ ]]
   do
    printf '%s\n' "Please, enter a valid phone number." 
    read CUSTOMER_PHONE
  done
  
  local query="SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'"
  local customer_found_phone
  customer_found_phone="$("${PSQL_ARR[@]}" -c "$query")"

  if [[ -z "$customer_found_phone" ]]
    then
      printf '%s\n' "What's your name?"
      read CUSTOMER_NAME

      while [[ ! "$CUSTOMER_NAME" =~ ^[A-Za-z]+$ ]]
        do
          printf '%s\n' "Please enter a valid name:"
          read CUSTOMER_NAME
        done

      insert_new_customer_query="INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')"
      "${PSQL_ARR[@]}" -c "$insert_new_customer_query" > /dev/null
      printf '%s\n' "Happy to be of service to you, $CUSTOMER_NAME"
    else
      local query="SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'"
      CUSTOMER_NAME="$("${PSQL_ARR[@]}" -c "$query")"
      printf '%s\n' "Hello, $CUSTOMER_NAME" 
  fi
}

appoint_client() {
  printf '%s\n' "What time would you like your appointment?"
  read SERVICE_TIME

  get_customer_id "$CUSTOMER_PHONE"

  local insert_new_appointment_query
  insert_new_appointment_query="INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME', '$CUSTOMER_ID', '$SERVICE_ID_SELECTED')"
  "${PSQL_ARR[@]}" -c "$insert_new_appointment_query" > /dev/null

  get_service_name_by_id "$SERVICE_ID_SELECTED"

  printf '%s\n' "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}



main_menu () {

  printf '\n%s\n\n' "~~~~~ MY SALON ~~~~~"
  printf '\n%s\n\n' "Welcome to My Salon, how can I help you?"
  
  show_services_list

  get_valid_appointment_choice
  
  process_customer

  appoint_client

}

main_menu


# ehh, pity it didn't count
: '
appoint_client() {
  printf '%s\n' "Please, enter your desired time of appointment, the format is 'hh:mm'."
  read SERVICE_TIME
  
  while true
    do
      if [[ ! "$SERVICE_TIME" =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$  ]]
        then
          printf '%s\n' "Please, enter valid time of appointment."
          read SERVICE_TIME
          continue
        else
          local query="SELECT time FROM appointments WHERE time='$SERVICE_TIME'"
          local if_time_is_occupied
          if_time_is_occupied="$("${PSQL_ARR[@]}" -c "$query")"
      fi

      if [[ ! -z "$if_time_is_occupied" ]]
        then
          printf '%s\n' "Sorry, that time is already occupied. Please, choose another:"
          read SERVICE_TIME
          continue
        else
          break
      fi
    done

  get_customer_id "$CUSTOMER_PHONE"
  local insert_new_appointment_query
  insert_new_appointment_query="INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME', '$CUSTOMER_ID', '$SERVICE_ID_SELECTED')"
  "${PSQL_ARR[@]}" -c "$insert_new_appointment_query"
  get_service_name_by_id "$SERVICE_ID_SELECTED"
  printf '%s\n' "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
'