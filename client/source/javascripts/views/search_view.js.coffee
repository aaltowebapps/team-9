class App.Views.SearchView extends App.Views.Page
  
  template: JST["templates/search"]
  el: "#content"

  initialize: (options) ->
    @gmaps = options.model
    @user = options.user
    @user.on("change", @updateLocation, @)
    super

  updateLocation: =>
    callback = (results) =>
      @user.set({ address: results[0].formatted_address.split(",")[0] })
      @user.save()
      @render()
    @gmaps.reverseGeoCode(@user.getLocationAsLatLng(), callback)


  render: =>
    @$el.html(@template(user: @user))
    @

  onSearchFormSubmit: (event) ->
    event.preventDefault()
    @user.set({ destination: @$('input[name=destination]').val() })
    Backbone.history.navigate("info", true)


  events:
    "submit #search_form" : "onSearchFormSubmit"