class App.Routers.Main extends Backbone.Router

  routes:
    "" : "search"
    "info" : "info"
    "map" : "map"

  initialize: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@currentPositionCallback)
    else
      console.log "No geolocation support"

    @header = new App.Views.HeaderView(el: $("#header"))

  currentPositionCallback: (position) =>
    sessionStorage.setItem("userLocation", JSON.stringify(position.coords))
     
  search: ->
    view = new App.Views.SearchView()
    @header.setActive(".home")

  info: ->
    view = new App.Views.InfoView()
    @header.setActive(".info")

  map: ->
    view = new App.Views.MapView()
    @header.setActive(".map")
