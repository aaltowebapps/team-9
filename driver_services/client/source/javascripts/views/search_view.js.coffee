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
    sessionStorage.setItem("userLocation", JSON.stringify(position.coords))

  onSearchFormSubmit: (event) ->
    event.preventDefault()
    sessionStorage.setItem("userDestination", @$('input[name=destination]').val())
    Backbone.history.navigate("info", true)


  events:
    "submit #search_form" : "onSearchFormSubmit"