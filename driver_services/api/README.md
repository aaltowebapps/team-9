# Driver Services API

Proxies (and simplifies) the [digitraffic API](http://www.infotripla.fi/digitraffic/)

## Installing dependencies

`bundle install`

## Setting up the database

`rake db:migrate`

`rake import:weather_stations`

## Loading observation data

(needs the settings.yml in config/ folder with api username and password)

`rake import:observation_data`

## Running the tests

`rake`

## Running the api server

`rails s`