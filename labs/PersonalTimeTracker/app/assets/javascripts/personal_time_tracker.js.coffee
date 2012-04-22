window.PersonalTimeTracker =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new PersonalTimeTracker.Routers.Tasks()    
    unless Backbone.history.started
      Backbone.history.start()
      Backbone.history.started = true

$(document).ready ->
  PersonalTimeTracker.init()