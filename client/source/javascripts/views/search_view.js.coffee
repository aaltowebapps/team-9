class App.Views.SearchView extends App.Views.Page
  
  template: JST["templates/search"]
  el: "#dynamic"

  render: =>
    @$el.html(@template())
    @

  onSearchFormSubmit: (event) ->
    event.preventDefault()
    sessionStorage.setItem("userDestination", @$('input[name=destination]').val())
    Backbone.history.navigate("info", true)


  events:
    "submit #search_form" : "onSearchFormSubmit"