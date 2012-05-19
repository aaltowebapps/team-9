class App.Views.InfoView extends App.Views.Page
  
  template: JST["templates/info"]

  DEFAULT_LOCATION = "Helsinki"

  initialize: (options) =>
    console.log sessionStorage
    if(rawData = sessionStorage.getItem("userLocation"))
      userLocationArray = JSON.parse(rawData)
      userLocation = new google.maps.LatLng(userLocationArray.latitude, userLocationArray.longitude)
    else
      userLocation = DEFAULT_LOCATION

    userDestination = sessionStorage.getItem("userDestination") || DEFAULT_LOCATION

    request =
      origin: userLocation
      destination: userDestination
      travelMode: google.maps.TravelMode.DRIVING

    service = new google.maps.DirectionsService()

    service.route request, (response, status) =>
      console.log response, status
      if status is "OK"
        leg = response.routes[0].legs[0]
        @duration = leg.duration.text
        @start_address = leg.start_address
        @end_address = leg.end_address
        @render()
      else
        console.log status

    super


  render: =>
    @$el.html(@template(duration: @duration, start_address: @start_address, end_address: @end_address))
    @

