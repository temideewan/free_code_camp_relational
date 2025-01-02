#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"


# echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU(){ 
  # if [[ $1 ]]
  # then
  #   echo -e "$1"
  # fi
  # echo -e "\nHi there welcome to our salon. These are the services that are available. Please select one:"
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME; do
      echo -e "$SERVICE_ID) $NAME"
    done
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAIN_MENU
  else
    SERVICE_SELECTED=$($PSQL "SELECT name FROM services where service_id=$SERVICE_ID_SELECTED");
    if [[ -z $SERVICE_SELECTED ]];
    then
      MAIN_MENU "There's no service that matches that id $SERVICE_ID_SELECTED"
    else 
      RENDER_SERVICE "$SERVICE_SELECTED"
    fi
  fi
}

RENDER_SERVICE(){
  echo -e "\nWhat's your phone number"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]] 
  then
    echo -e "\nLooks like you're not yet registered with us, please what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) values('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  echo -e "\nWhat time would you like to get your '$1' service"
  read SERVICE_TIME
  
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $1 at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU
