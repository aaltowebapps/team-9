class App.Views.InfoView extends Backbone.View
  
  template: JST["templates/info"]

  initialize: =>
    @$el.removeClass("map container-fluid")
    @$el.addClass("container")


  render: =>
    @$el.html(@template())
    @

