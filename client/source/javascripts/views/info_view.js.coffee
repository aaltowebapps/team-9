class App.Views.InfoView extends Backbone.View
  
  template: JST["templates/info"]

  initialize: (options) =>
    console.log sessionStorage
    userLocationArray = JSON.parse(sessionStorage.getItem("userLocation"))
    userLocation = new google.maps.LatLng(userLocationArray.latitude, userLocationArray.longitude)

    userDestination = sessionStorage.getItem("userDestination")

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


    @$el.removeClass("map container-fluid")
    @$el.addClass("container")


  render: =>
    @$el.html(@template(duration: @duration, start_address: @start_address, end_address: @end_address))
    @

