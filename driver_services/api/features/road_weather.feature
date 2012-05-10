Feature: Road weather

  Scenario: Return an array of weather stations
    Given the following weather stations exist:
      | location    | road      | 
      | u4pruydqqvj | 1         | 
    When I send a GET request for "/weather_stations"
    Then the response status should be "200"
    And the JSON response should have "$.weather_stations.[0].location" with the text "u4pruydqqvj"
    And the JSON response should have "$.weather_stations.[0].road" with the text "1"


  Scenario: Return a single weather station
    Given a weather station exists with id: 1
    And an observation data exists with weather_station: the weather station, temperature: 13, visibility: 2000
    When I send a GET request for "/weather_stations/1"
    Then the response status should be "200"
    And the JSON response should have "$.weather_station.observation_data.temperature" with the text "13"
    And the JSON response should have "$.weather_station.observation_data.visibility" with the text "2000"