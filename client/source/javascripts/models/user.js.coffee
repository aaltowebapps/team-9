class App.Models.User extends Backbone.Model

  localStorage: new Backbone.LocalStorage("User")

  defaults:
    address: undefined
    latitude: 60.166591
    longitude: 24.943565
    destination: "Helsinki"

  initialize: =>
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@currentPositionCallback)
    else
      console.log "No geolocation support"

  currentPositionCallback: (position) =>
    @set({ latitude: position.coords.latitude, longitude: position.coords.longitude })
    callback = (results) =>
      @set({ address: results[0].formatted_address.split(",")[0] })
      @save()
    @reverseGeoCode(@getLocationAsLatLng(), callback)

  getLocationAsLatLng: =>
    new google.maps.LatLng(@get("latitude"), @get("longitude"))

  reverseGeoCode: (latlng, callback) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode
      latLng: latlng
    , (results, status) ->
      callback(results) if status is google.maps.GeocoderStatus.OK

  geoCode: (address, callback) ->
    geocoder.geocode
      address: address
    , (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        callback(results)
      else
        alert "Geocode was not successful for the following reason: " + status

