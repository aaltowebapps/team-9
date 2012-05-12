Feature: Road weather

  Scenario: Return an array of weather stations
    Given the following weather stations exist:
      | latitude | longitude | road      | 
      | 12.345   | 67.89     | 1         |
      | 42.345   | 27.36     | 5         |
    When I send a GET request for "/weather_stations"
    Then the response status should be "200"
    And the JSON response should have 2 weather stations
    And the JSON response at "0/latitude" should be 12.345
    And the JSON response at "0/longitude" should be 67.89
    And the JSON response at "0/road" should be 1


  Scenario: Return all weather stations with a single road
    Given the following weather stations exist:
    | id | road | 
    | 1  | 1    |
    | 2  | 2    |
    | 3  | 1    |
    When I send a GET request for "/weather_stations?road=1"
    Then the response status should be "200"
    And the JSON response should have 2 weather stations
    And the JSON response at "0/id" should be 1
    And the JSON response at "1/id" should be 3


  Scenario: Return 10 weather stations near my location
    Given the following weather stations exist:
    | id  | latitude | longitude |
    | 1   | 1        | 1         |
    | 2   | 10       | 10        |
    | 3   | 2        | 3         |
    | 4   | 2        | 3         |
    | 5   | 2        | 3         |
    | 6   | 2        | 3         |
    | 7   | 2        | 3         |
    | 8   | 2        | 3         |
    | 9   | 2        | 3         |
    | 10  | 2        | 3         |
    | 11  | 2        | 3         |
    When I send a GET request for "/weather_stations?latitude=1.1&longitude=1.2"
    Then the response status should be "200"
    And the JSON response should have 10 weather stations
    And the JSON response at "0/id" should be 1
    And the JSON response at "1/id" should be 3


  Scenario: Return a single weather station
    Given a weather station exists with id: 1
    And an observation data exists with weather_station: the weather station, temperature: 13, visibility: 2000
    When I send a GET request for "/weather_stations/1"
    Then the response status should be "200"
    And the JSON response at "observation_data/temperature" should be 13
    And the JSON response at "observation_data/visibility" should be 2000