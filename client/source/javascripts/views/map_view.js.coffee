class App.Views.MapView extends App.Views.Page
  
  template: JST["templates/map"]

  className: "map"

  initialize: (options) ->
    @gmaps = options.model
    @user = options.user
    @userLocation = @user.getLocationAsLatLng()
    @userDestination = @user.destination
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

    @setupDirections() if @userDestination?

    $("[data-toggle=button]").button("toggle")


  setupPlaces: =>
    request =
      location: @userLocation
      radius: @gmaps.placeRadius
      types: @gmaps.placeTypes

    @placesLayer = new google.maps.places.PlacesService(@map)
    @placesLayer.search request, (results, status) =>
      if status is google.maps.places.PlacesServiceStatus.OK
        @markersArray = []
        for result in results
          place = result
          @markersArray.push new google.maps.Marker
            position: result.geometry.location
            map: @mapCanvas
            title: result.name
            icon: '/img/gas_station.png'


  setupDirections: =>
    directionsRenderer = new google.maps.DirectionsRenderer()
    directionsRenderer.setMap @map
    directionsRenderer.setPanel $("#directions_panel")[0]


    request =
      origin: @userLocation
      destination: @userDestination
      travelMode: @gmaps.travelMode
      unitSystem: @gmaps.unitSystem

    @gmaps.requestDirections request, (response, status) ->
      directionsRenderer.setDirections response

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


