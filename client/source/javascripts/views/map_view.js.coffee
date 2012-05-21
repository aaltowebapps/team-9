class App.Views.MapView extends App.Views.Page
  
  template: JST["templates/map"]

  className: "map"

  initialize: (options) ->
    @gmaps = options.model
    @user = options.user
    @user.on("change", @updatePosition, @)
    @userLocation = @user.getLocationAsLatLng()
    @destination = @user.get("destination")
    @markersArray = []
    @markerIds = []


    super
  
  render: =>
    @$el.html(@template())
    @renderMap()
    @

  renderMap: =>
    myOptions =
      zoom: 13
      mapTypeId: google.maps.MapTypeId.ROADMAP
      center: @userLocation
      mapTypeControl: false
      zoomControl: google.maps.ZoomControlStyle.SMALL
      panControl: false
    @map = new google.maps.Map($("#map_canvas")[0], myOptions)

    @userMarker = new google.maps.Marker
              position: @userLocation
              map: @map
              title: "Your location"
              zIndex: 9999
              icon: "/img/marker.png"


    @trafficLayer = new google.maps.TrafficLayer()
    @toggleLayer(@trafficLayer)

    @weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS
    @toggleLayer(@weatherLayer)


    @placesLayer = new google.maps.places.PlacesService(@map)



    google.maps.event.addListener @map, "idle", =>
      request =
        bounds: @map.getBounds()
        types: @gmaps.placeTypes
      @loadPlace(request)

    @setupDirections() if @destination?


    $("[data-toggle=button]").button("toggle")

  updatePosition: =>
    return unless @userMarker?
    @userLocation = @user.getLocationAsLatLng()
    @userMarker.setPosition(@userLocation)
    @map.setCenter(@userLocation)
    #@requestDirections()


  loadPlaces: (locations) =>
    return unless locations.length > 0
    #return if @map.getZoom() < 10
    

    @lastRequest = new Date()

    request =
      location: locations.shift()
      radius: 20000
      types: @gmaps.placeTypes

    @loadPlace(request)

    setTimeout => 
      @loadPlaces(locations)
    , 300

  loadPlace: (request) =>
    return unless !@markersArray[0] || @markersArray[0].getMap()?
    @placesLayer.search request, (results, status) =>
      if status is google.maps.places.PlacesServiceStatus.OK
        oldMarkerCount = @markerIds.length
        for result in results
          if "lodging" in result.types
            icon = "/img/hotel.png"
          else if "car_repair" in result.types
            icon = "/img/car_repair.png"
          else
            icon = "/img/gas_station.png"

          unless result.id in @markerIds
            place = new google.maps.Marker
              position: result.geometry.location
              map: @map
              title: result.name
              icon: icon
            @markersArray.push place
            @markerIds.push result.id




  setupDirections: =>
    @directionsLayer = new google.maps.DirectionsRenderer()
    @directionsLayer.setMap @map
    @directionsLayer.setPanel $("#directions_panel")[0]
    @requestDirections()

  requestDirections: =>
    request =
      origin: @userLocation
      destination: @destination
      travelMode: @gmaps.travelMode
      unitSystem: @gmaps.unitSystem

    @gmaps.requestDirections request, (response, status) =>
      @directionsLayer.setDirections response
      @loadPlaces(_.pluck(response.routes[0].legs[0].steps, "start_location"))

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


