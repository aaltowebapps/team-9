class App.Views.Page extends Backbone.View
  el: "#content"

  initialize: =>
    @render()
    $(".nav-collapse").collapse("hide")