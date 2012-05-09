class App.Views.SearchView extends Backbone.View
  
  template: JST["templates/search"]

  initialize: =>
    @$el.removeClass("map container-fluid")
    @$el.addClass("container")



  render: =>
    console.log @$el
    @$el.html(@template())
    @

