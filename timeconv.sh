#! /usr/bin/bash


regex='(0[0-9]|1[0-2]):([0-9][0-9])(AM|PM|am|pm)'


while read line; do
    while [[ $line =~ $regex ]]; do
        hour=${BASH_REMATCH[1]}
        min=${BASH_REMATCH[2]}
        ampm=${BASH_REMATCH[3]}

        if [[ "${ampm^^}" = "AM" ]]; then
            hour=$(expr $hour + 12)
        fi


        line=${line/"${BASH_REMATCH[0]}"/"$hour:$min"}
    done

    echo $line
done
