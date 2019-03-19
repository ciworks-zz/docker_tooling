#!/bin/bash

unset options i
while IFS= read -r line;
do
  options[i++]="$line"
done < <(sudo docker ps --format {{.Names}} )

options+=("Quit");

PS3='Please enter your choice: '
select opt in "${options[@]}"
do
  if [ "$REPLY" -eq "${#options[@]}" ];
  then
    echo "Exiting..."
    break;
elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le ${#options[@]} ];
  then
    docker exec -it ${opt} bash
    break;
  else
    echo "Incorrect Input: Select a number 1-${#options[@]}"
  fi
done
