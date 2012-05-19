window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    main_router = new App.Routers.Main()
    Backbone.history.start()

$(document).ready ->
  App.init()