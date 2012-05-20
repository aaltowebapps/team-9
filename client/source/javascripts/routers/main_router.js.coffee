class App.Routers.Main extends Backbone.Router

  routes:
    "" : "search"
    "info" : "info"
    "map" : "map"

  initialize: ->
    @gmaps = new App.Models.GMaps()
    @user = new App.Models.User({ id: 1 })
    @user.fetch()
    @header = new App.Views.HeaderView(el: $("#header"), model: @user)
     
  search: ->
    view = new App.Views.SearchView(model: @gmaps, user: @user)
    @header.setActive(".home")

  info: ->
    view = new App.Views.InfoView(model: @gmaps, user: @user)
    @header.setActive(".route")

  map: ->
    view = new App.Views.MapView(model: @gmaps, user: @user)
    @header.setActive(".map")
