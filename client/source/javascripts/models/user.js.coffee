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
    @save
    @trigger("locationChanged")

  getLocationAsLatLng: =>
    new google.maps.LatLng(@get("latitude"), @get("longitude"))