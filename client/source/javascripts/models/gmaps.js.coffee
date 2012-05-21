class App.Models.GMaps extends Backbone.Model
  
  default_location: "helsinki"
  travelMode: google.maps.DirectionsTravelMode.DRIVING
  unitSystem: google.maps.DirectionsUnitSystem.METRIC
  placeTypes: [ "gas_station", "lodging", "car_repair" ]

  initialize: =>
    @directionsService = new google.maps.DirectionsService()

    
  requestDirections: (request, callback) ->
    @directionsService.route request, (response, status, error) =>
      if status is google.maps.DirectionsStatus.OK
        callback(response, status)