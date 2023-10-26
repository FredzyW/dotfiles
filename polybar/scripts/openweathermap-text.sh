#!/bin/sh

KEY="67627eca545cf273ea4e345011d59b29"
# CITY="Malmö"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"


if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi
    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf "ipinfo.io" | jq ".city" | sed 's/^"\(.*\)"$/\1/')
    
    weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$KEY")
fi

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    temp=$(echo "$weather_temp - 273" | bc)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "$temp$SYMBOL"
fi
