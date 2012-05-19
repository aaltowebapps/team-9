class App.Views.HeaderView extends Backbone.View
  
  template: JST["templates/header"]

  initialize: ->
    @render()

  render: =>
    @$el.html(@template())
    @

  setActive: (className) ->
    @$("li").removeClass("active")
    @$(className).addClass("active")


  onSearchFormSubmit: (event) ->
    event.preventDefault()
    sessionStorage.setItem("userDestination", @$('input[name=destination]').val())
    Backbone.history.fragment = null
    Backbone.history.navigate("info", true)

  events:
    "submit #header_search_form" : "onSearchFormSubmit"

