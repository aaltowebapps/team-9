class App.Views.HeaderView extends Backbone.View
  
  template: JST["templates/header"]

  initialize: (options) ->
    @user = options.model
    @render()

  render: =>
    @$el.html(@template())
    @

  setActive: (className) ->
    @$("li").removeClass("active")
    @$(className).addClass("active")


  onSearchFormSubmit: (event) ->
    event.preventDefault()
    destination = @$('input[name=destination]').val()
    return if destination.length < 3
    @user.set({ destination: destination })
    Backbone.history.fragment = null
    Backbone.history.navigate("info", true)

  events:
    "submit #header_search_form" : "onSearchFormSubmit"

