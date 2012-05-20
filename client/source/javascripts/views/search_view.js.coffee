class App.Views.SearchView extends App.Views.Page
  
  template: JST["templates/search"]
  el: "#content"

  initialize: (options) ->
    @gmaps = options.model
    @user = options.user
    @user.on("locationChanged", @updateLocation, @)
    @user.on("change", @render, @)
    super

  render: =>
    @$el.html(@template(user: @user))
    @

  onSearchFormSubmit: (event) ->
    event.preventDefault()
    destinationField = @$('input[name=destination]')
    destination = destinationField.val()

    if destination.length < 3
      destinationField.addClass("error") 
      return false


    customAddress = @$('input[name=location]').val()
    if customAddress.length > 3
      address = customAddress
    else
      address = @$('input[name=location]').attr("placeholder")
    @user.set({ address: address, destination: destination })
    @user.save()
    Backbone.history.navigate("info", true)


  events:
    "submit #search_form" : "onSearchFormSubmit"