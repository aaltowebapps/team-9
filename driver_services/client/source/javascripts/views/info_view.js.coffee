class App.Views.InfoView extends Backbone.View
  
  template: JST["templates/info"]

  initialize: (options) =>
    service = new google.maps.DirectionsService()

    request =
      origin: if options.origin? then options.origin else new google.maps.LatLng(41.886943,-87.664719)
      destination: if options.destination? then options.destination else "Los Angeles, CA"
      travelMode: google.maps.TravelMode.DRIVING

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

