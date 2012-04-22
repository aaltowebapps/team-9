class App.Views.MapView extends Backbone.View
  
  className: "map"



  initialize: =>
    console.log("Rendering templates/examples/index in examples.js.coffee")
    myOptions =
      zoom: 13
      center: new google.maps.LatLng(60.166757, 24.943705)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map($(this.el)[0], myOptions)
    
    @trafficLayer = new google.maps.TrafficLayer()
    @trafficLayer.setMap(@map)

    @weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS

    @weatherLayer.setMap(@map)

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
    this

  toggleLayer: (layer) =>
    layer.setMap(if layer.getMap()? then null else @map)


  currentPositionCallback: (position) =>
    console.log position
    userCoordinates = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    console.log userCoordinates
    @map.setCenter(userCoordinates)

