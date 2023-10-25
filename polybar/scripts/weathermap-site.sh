#!/bin/sh

KEY="67627eca545cf273ea4e345011d59b29"

location=$(curl -sf "ipinfo.io" | jq ".city" | sed 's/^"\(.*\)"$/\1/')

if [ -n "$location" ]; then
    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"
fi
weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$KEY")
# obj=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?lat=$location_lat&lon=$location_lon&appid=$KEY")

city_id="$(echo "$weather" | jq '.id')"

# echo $city_id

if [ -n "$city_id" ]; then
    firefox "https://openweathermap.org/city/$city_id"
fi
