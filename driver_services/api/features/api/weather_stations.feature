Feature: Weather stations

  Scenario: Return an array of weather stations
    Given the following weather stations exist:
      | location    | temperature | visibility  | 
      | u4pruydqqvj | 13          | 2000        | 
    When I send a GET request for "/weather_stations"
    Then the response status should be "200"
    And the JSON response should have "$.[0].location" with the text "u4pruydqqvj"
    And the JSON response should have "$.[0].temperature" with the text "13"
    And the JSON response should have "$.[0].visibility" with the text "2000"