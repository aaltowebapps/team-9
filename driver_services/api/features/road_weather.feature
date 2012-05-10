Feature: Road weather

  Scenario: Return an array of weather stations
    Given the following weather stations exist:
      | latitude | longitude | road      | 
      | 12.345   | 67.89     | 1         |
    When I send a GET request for "/weather_stations"
    Then the response status should be "200"
    And the JSON response should have "$.[0].latitude" with the text "12.345"
    And the JSON response should have "$.[0].longitude" with the text "67.89"
    And the JSON response should have "$.[0].road" with the text "1"


  Scenario: Return a single weather station
    Given a weather station exists with id: 1
    And an observation data exists with weather_station: the weather station, temperature: 13, visibility: 2000
    When I send a GET request for "/weather_stations/1"
    Then the response status should be "200"
    And the JSON response should have "$.observation_data.temperature" with the text "13"
    And the JSON response should have "$.observation_data.visibility" with the text "2000"