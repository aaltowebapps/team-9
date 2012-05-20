class App.Views.InfoView extends App.Views.Page
  
  template: JST["templates/info"]

  initialize: (options) =>

    @gmaps = options.model
    @user = options.user

    @userLocation = @user.getLocationAsLatLng()
    @userDestination = @user.get("destination")
    request =
      origin: @userLocation
      destination: @userDestination
      travelMode: @gmaps.travelMode

    @gmaps.requestDirections request, (response, status) =>
      leg = response.routes[0].legs[0]
      @duration = leg.duration.text
      @start_address = leg.start_address
      @end_address = leg.end_address
      @render()

    console.log @duration

    super


  render: =>
    console.log @duration
    @$el.html(@template(duration: @duration, start_address: @start_address, end_address: @end_address))
    @

