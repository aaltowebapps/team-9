class App.Views.MapView extends Backbone.View
  
  template: JST["templates/map"]

  
  initialize: (options) =>
    # TODO: Figure out cleaner solution
    @$el.removeClass("container")
    @$el.addClass("map container-fluid")

    @userLocation = if options.location then new google.maps.LatLng(options.latitude, options.longitude) else new google.maps.LatLng(41.886943,-87.664719)
    console.log @userLocation

  render: =>
    @$el.html(@template())
    @renderMap()
    @

  renderMap: =>
    myOptions =
      zoom: 13
      mapTypeId: google.maps.MapTypeId.ROADMAP
      center: @userLocation
    @map = new google.maps.Map($("#map_canvas")[0], myOptions)
    
    @trafficLayer = new google.maps.TrafficLayer()
    @toggleLayer(@trafficLayer)

    @weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS
    @toggleLayer(@weatherLayer)

    @setupPlaces()

    $(".toggle-traffic, .toggle-conditions, .toggle-places").button("toggle")

  toggleLayer: (layer) =>
    layer.setMap(if layer.getMap()? then null else @map)


  currentPositionCallback: (position) =>


  setupPlaces: =>
    request =
      location: @userLocation
      radius: "5000"
      types: [ "gas_station" ]




    @placesLayer = new google.maps.places.PlacesService(@map)
    @placesLayer.search request, (results, status) =>
      if status is google.maps.places.PlacesServiceStatus.OK
        @markersArray = []
        for result in results
          place = result
          @markersArray.push new google.maps.Marker
            position: result.geometry.location
            map: @map
            title: result.name
            icon: '/img/gas_station.png'


      else
        console.log status

    directionsRenderer = new google.maps.DirectionsRenderer()
    directionsRenderer.setMap @map
    directionsRenderer.setPanel document.getElementById("directionsPanel")
    directionsService = new google.maps.DirectionsService()
    request =
      origin: "316 N Laflin St, Chicago, IL 60607, USA"
      destination: "Los Angeles, CA"
      travelMode: google.maps.DirectionsTravelMode.DRIVING
      unitSystem: google.maps.DirectionsUnitSystem.METRIC

    directionsService.route request, (response, status) ->
      if status is google.maps.DirectionsStatus.OK
        directionsRenderer.setDirections response
        
      else
        alert "Error: " + status

  toggleOverlays: =>
    for marker in @markersArray
      marker.setMap if marker.getMap()? then null else @map

  toggleTrafficLayer: =>
    @toggleLayer(@trafficLayer)

  toggleWeatherLayer: =>
    @toggleLayer(@weatherLayer)

  events:
    "click .toggle-traffic" : "toggleTrafficLayer"
    "click .toggle-conditions" : "toggleWeatherLayer"
    "click .toggle-places" : "toggleOverlays"
