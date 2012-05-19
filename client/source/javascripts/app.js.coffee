window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    console.log("Initialized Backbone application")
    new App.Routers.Main
    Backbone.history.start()

$(document).ready ->
  App.init()