class App.Routers.Main extends Backbone.Router
  routes:
    '': 'index'

  initialize: ->
    @collection = new App.Collections.Examples()
    @collection.fetch()
                
  index: ->
    view = new App.Views.MapView()
    console.log("Inserting rendered content from App.Views.Map into #container")
    $('#container').html(view.render().el)