class App.Views.MapView extends App.Views.Page
  
  template: JST["templates/map"]

  className: "map"

  initialize: (options) ->
    @gmaps = options.model
    @user = options.user
    @userLocation = @user.getLocationAsLatLng()
    @destination = @user.get("destination")
    @markersArray = []

    super
  
  render: =>
    @$el.html(@template())
    @renderMap()
    @

  renderMap: =>
    myOptions =
      zoom: @gmaps.zoom
      mapTypeId: @gmaps.mapTypeId
      center: @userLocation
    @map = new google.maps.Map($("#map_canvas")[0], myOptions)
    
    @trafficLayer = new google.maps.TrafficLayer()
    @toggleLayer(@trafficLayer)

    @weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS
    @toggleLayer(@weatherLayer)

    @setupPlaces()

    google.maps.event.addListener @map, "bounds_changed", (event) =>
      @setupPlaces() if new Date().getTime() - @lastRequest.getTime() > 200

    @setupDirections() if @destination?


    $("[data-toggle=button]").button("toggle")


  setupPlaces: =>
    return if @map.getZoom() < 10
    return unless !@markersArray[0] || @markersArray[0].getMap()?
    @lastRequest = new Date()
    request =
      location: @map.getCenter()
      radius: @gmaps.placeRadius
      types: @gmaps.placeTypes

    @placesLayer = new google.maps.places.PlacesService(@map)
    @placesLayer.search request, (results, status) =>
      if status is google.maps.places.PlacesServiceStatus.OK
        for result in results
          place = result
          @markersArray.push new google.maps.Marker
            position: result.geometry.location
            map: @map
            title: result.name
            icon: "/img/gas_station.png"





  setupDirections: =>
    @directionsLayer = new google.maps.DirectionsRenderer()
    @directionsLayer.setMap @map
    @directionsLayer.setPanel $("#directions_panel")[0]

    request =
      origin: @userLocation
      destination: @destination
      travelMode: @gmaps.travelMode
      unitSystem: @gmaps.unitSystem

    @gmaps.requestDirections request, (response, status) =>
      @directionsLayer.setDirections response

  toggleLayer: (layer) =>
    layer.setMap(if layer.getMap()? then null else @map)

  toggleOverlays: =>
    for marker in @markersArray
      marker.setMap if marker.getMap()? then null else @map

  toggleTrafficLayer: =>
    @toggleLayer(@trafficLayer)

  toggleWeatherLayer: =>
    @toggleLayer(@weatherLayer)

  toggleDirectionsLayer: =>
    @toggleLayer(@directionsLayer)


  events:
    "click .toggle-traffic" : "toggleTrafficLayer"
    "click .toggle-conditions" : "toggleWeatherLayer"
    "click .toggle-directions" : "toggleDirectionsLayer"
    "click .toggle-places" : "toggleOverlays"


