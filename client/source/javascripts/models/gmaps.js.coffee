class App.Models.GMaps extends Backbone.Model
  
  default_location: "helsinki"
  zoom: 13
  mapTypeId: google.maps.MapTypeId.ROADMAP
  travelMode: google.maps.DirectionsTravelMode.DRIVING
  unitSystem: google.maps.DirectionsUnitSystem.METRIC
  placeRadius: 10000
  placeTypes: [ "gas_station" ]

  initialize: =>
    @directionsService = new google.maps.DirectionsService()

    
  requestDirections: (request, callback) ->
    @directionsService.route request, (response, status) =>
      if status is google.maps.DirectionsStatus.OK
        callback(response, status)