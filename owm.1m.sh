#! /bin/bash

#  <xbar.title>OWM Weather Bar</xbar.title>
#  <xbar.version>v0.1</xbar.version>
#  <xbar.author>Jonatan Ivanov</xbar.author>
#  <xbar.author.github>jonatan-ivanov</xbar.author.github>
#  <xbar.desc>Minimalistic OpenWeatherMap bar</xbar.desc>
#  <xbar.image>https://openweathermap.org/themes/openweathermap/assets/img/logo_white_cropped.png</xbar.image>
#  <xbar.dependencies>bash,curl,jq</xbar.dependencies>
#  <xbar.abouturl>https://develotters.com</xbar.abouturl>

#  <xbar.var>string(VAR_ZIP_CODE=""): see: https://openweathermap.org/current#zip</xbar.var>
#  <xbar.var>string(VAR_API_KEY=""): see: https://home.openweathermap.org/api_keys</xbar.var>

function printIcon() {
    if (($1 >= 200 && $1 < 300))
    then
        echo '⛈️'
    elif (($1 >= 300 && $1 < 400))
    then
        echo '🌧️'
    elif (($1 >= 500 && $1 < 600))
    then
        echo '🌧️'
    elif (($1 >= 600 && $1 < 700))
    then
        echo '🌨️'
    elif (($1 == 781))
    then
        echo '🌪️'
    elif (($1 >= 700 && $1 < 800))
    then
        echo '🌫️'
    elif (($1 == 800))
    then
        echo '☀️'
    elif (($1 == 801))
    then
        echo '🌤️'
    elif (($1 == 802))
    then
        echo '⛅'
    elif (($1 == 803))
    then
        echo '🌥️'
    elif (($1 == 804))
    then
        echo '☁️'
    else
        echo ''
    fi
}

WEATHER_DATA=$(curl --silent "https://api.openweathermap.org/data/2.5/weather?zip=${VAR_ZIP_CODE}&units=metric&appid=${VAR_API_KEY}")

echo "$WEATHER_DATA" | /opt/homebrew/bin/jq -j '"\(.main.temp | tonumber | round)°C "'
printIcon "$(echo "$WEATHER_DATA" | /opt/homebrew/bin/jq -r '.weather[0].id')"
echo '---'
echo "$WEATHER_DATA" | /opt/homebrew/bin/jq -r '"\(.weather[0].main), feels like: \(.main.feels_like | tonumber | round)°C\n---\nmin/max: \(.main.temp_min | tonumber | round)-\(.main.temp_max | tonumber | round)°C"'
