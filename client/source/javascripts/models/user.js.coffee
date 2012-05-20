class App.Models.User extends Backbone.Model
  defaults:
    address: undefined
    latitude: 60
    longitude: 20
    destination: "helsinki"

  initialize: =>
    @latitude = sessionStorage.getItem("latitude") if sessionStorage.getItem("latitude")?
    @longitude = sessionStorage.getItem("longitude") if sessionStorage.getItem("longitude")?
    @destination = sessionStorage.getItem("destination") if sessionStorage.getItem("destination")?

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@currentPositionCallback)
    else
      console.log "No geolocation support"

  currentPositionCallback: (position) =>
    @latitude = position.coords.latitude
    @longitude = position.coords.longitude
    sessionStorage.setItem("latitude", @latitude)
    sessionStorage.setItem("longitude", @longitude)
    @trigger("locationChanged")

  getLocationAsLatLng: =>
    new google.maps.LatLng(@latitude, @longitude)