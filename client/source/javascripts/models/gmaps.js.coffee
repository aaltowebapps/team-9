class App.Models.GMaps extends Backbone.Model
  
  mapTypeControl: false
  default_location: "helsinki"
  zoom: 13
  travelMode: google.maps.DirectionsTravelMode.DRIVING
  unitSystem: google.maps.DirectionsUnitSystem.METRIC
  placeRadius: 10000
  placeTypes: [ "gas_station", "lodging", "car_repair" ]

  initialize: =>
    @directionsService = new google.maps.DirectionsService()

    
  requestDirections: (request, callback) ->
    @directionsService.route request, (response, status, error) =>
      if status is google.maps.DirectionsStatus.OK
        callback(response, status)