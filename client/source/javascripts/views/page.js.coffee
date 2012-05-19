class App.Views.Page extends Backbone.View
  el: "#dynamic"

  initialize: =>
    @render()
    $(".nav-collapse").collapse("hide")