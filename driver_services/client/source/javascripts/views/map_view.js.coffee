class App.Views.MapView extends Backbone.View
  
  className: "map"

  initialize: =>
    myOptions =
      zoom: 13
      center: new google.maps.LatLng(60.166757, 24.943705)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map($(this.el)[0], myOptions)
    
    @trafficLayer = new google.maps.TrafficLayer()
    @toggleLayer(@trafficLayer)

    @weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS
    @toggleLayer(@weatherLayer)

    if navigator.geolocation
      console.log "Geolocation is supported"
      navigator.geolocation.getCurrentPosition(@currentPositionCallback)
    else
      console.log "No geolocation support"


  render: =>
    $(".toggle-traffic").click =>
      @toggleLayer(@trafficLayer)
    $(".toggle-conditions").click =>
      @toggleLayer(@weatherLayer)
    $(".toggle-places").click =>
      @toggleOverlays()

    $(".toggle-traffic, .toggle-conditions, .toggle-places").button("toggle")
    this

  toggleLayer: (layer) =>
    layer.setMap(if layer.getMap()? then null else @map)


  currentPositionCallback: (position) =>
    @userLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    @map.setCenter(@userLocation)

    @setupPlaces()


  setupPlaces: =>
    pyrmont = new google.maps.LatLng(-33.8665433, 151.1956316)
    request =
      location: @userLocation
      radius: "5000"
      types: [ "gas_station" ]


    @placesLayer = new google.maps.places.PlacesService(@map)
    @placesLayer.search request, (results, status) =>
      if status is google.maps.places.PlacesServiceStatus.OK
        i = 0
        console.log "places ok"
        @markersArray = []
        for result in results
          place = result
          @markersArray.push new google.maps.Marker
            position: result.geometry.location
            map: @map
            title: result.name

      else
        console.log status

  toggleOverlays: =>
    for marker in @markersArray
      marker.setMap if marker.getMap()? then null else @map
