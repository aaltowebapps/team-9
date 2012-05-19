class App.Routers.Main extends Backbone.Router

  routes:
    "" : "search"
    "info" : "info"
    "map" : "map"

  initialize: ->
    $("#dynamic").before( new App.Views.HeaderView().render().el )
     
  search: ->
    console.log "Rendering search view"
    view = new App.Views.SearchView(el: $("#dynamic"))
    view.render()

  info: ->
    console.log "Rendering info view"
    view = new App.Views.InfoView(el: $("#dynamic"))
    view.render()

  map: ->
    console.log "Rendering map view"
    view = new App.Views.MapView(el: $('#dynamic'), className: "map")
    view.render().el