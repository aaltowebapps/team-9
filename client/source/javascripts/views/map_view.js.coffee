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

    @loadPlaces()

    @setupDirections() if @destination?


    $("[data-toggle=button]").button("toggle")


  loadPlaces: =>
    setTimeout => 
      @loadPlaces()
    , 500
    return if @map.getZoom() < 10
    return unless !@markersArray[0] || @markersArray[0].getMap()?
    @lastRequest = new Date()
    request =
      location: @map.getCenter()
      radius: @gmaps.placeRadius
      types: @gmaps.placeTypes

    @placesLayer = new google.maps.places.PlacesService(@map)

    @placesLayer.search request, (results, status) =>
      tempMarkersArray = []
      if status is google.maps.places.PlacesServiceStatus.OK
        for result in results
          if "lodging" in result.types
            icon = "/img/hotel.png"
          else if "car_repair" in result.types
            icon = "/img/car_repair.png"
          else
            icon = "/img/gas_station.png"

          place = new google.maps.Marker
            position: result.geometry.location
            map: @map
            title: result.name
            id: result.id
            icon: icon
          tempMarkersArray.push place
      @markersArray = _.union(@markersArray, tempMarkersArray)





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


