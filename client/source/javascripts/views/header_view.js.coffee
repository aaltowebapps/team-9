class App.Views.HeaderView extends Backbone.View
  
  template: JST["templates/header"]

  render: =>
    @$el.html(@template())
    @

  onSearchFormSubmit: (event) ->
    console.log @$('input[name=destination]').val()
    event.preventDefault()
    sessionStorage.setItem("userDestination", @$('input[name=destination]').val())
    Backbone.history.fragment = null
    Backbone.history.navigate("info", true)

  events:
    "submit #header_search_form" : "onSearchFormSubmit"

