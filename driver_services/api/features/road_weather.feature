Feature: Road weather

  Scenario: Return an array of weather stations
    Given the following weather stations exist:
      | road | 
      | 1    |
      | 5    |
    When I send a GET request for "/weather_stations"
    Then the response status should be "200"
    And the JSON response should have 2 weather stations
    And the JSON response at "0/road" should be 1


  Scenario: Return all weather stations with a single road
    Given the following weather stations exist:
    | road | 
    | 1    |
    | 2    |
    | 1    |
    When I send a GET request for "/weather_stations?weather_station[road]=1"
    Then the response status should be "200"
    And the JSON response should have 2 weather stations
    And the JSON response at "0/road" should be 1
    And the JSON response at "1/road" should be 1


  Scenario: Return 10 weather stations near my location
    Given 10 weather stations exist
    And 1 weather stations exist with location: [1.3, 1.4]
    When I send a GET request for "/weather_stations?weather_station[location][]=1.1&weather_station[location][]=1.2"
    Then the response status should be "200"
    And the JSON response should have 10 weather stations
    And the JSON response at "0/location/0" should be 1.3
    And the JSON response at "0/location/1" should be 1.4


  Scenario: Return a single weather station
    Given a weather station exists with id: "4baa56f1230048567300485c"
    And an observation data exists with weather_station: the weather station, temperature: 13, visibility: 2000
    When I send a GET request for "/weather_stations/4baa56f1230048567300485c"
    Then the response status should be "200"
    And the JSON response at "observation_data/temperature" should be 13
    And the JSON response at "observation_data/visibility" should be 2000