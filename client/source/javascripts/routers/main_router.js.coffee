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
    @setView(App.Views.SearchView, ".home")

  info: ->
    @setView(App.Views.InfoView, ".info")

  map: ->
    @setView(App.Views.MapView, ".map")

  setView: (ViewClass, name) ->
    @activeView.close() if @activeView?
    view = new ViewClass(model: @gmaps, user: @user)
    @activeView = view
    @header.setActive(name)
