class App.Views.SearchView extends Backbone.View
  
  template: JST["templates/search"]

  initialize: =>
    @$el.removeClass("map container-fluid")
    @$el.addClass("container")

    if navigator.geolocation
      console.log "Geolocation is supported"
      navigator.geolocation.getCurrentPosition(@currentPositionCallback)
    else
      console.log "No geolocation support"

  render: =>
    console.log @$el
    @$el.html(@template())
    @


  currentPositionCallback: (position) =>
    @userLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)

  onSearchFormSubmit: (event) =>
    console.log "foo"

  events:
    "submit #search_form" : "onSearchFormSubmit"