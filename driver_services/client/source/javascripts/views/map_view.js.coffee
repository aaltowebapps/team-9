class App.Views.MapView extends Backbone.View
  
  className: "map"

  initialize: =>
    console.log("Rendering templates/examples/index in examples.js.coffee")
    myOptions =
      zoom: 13
      center: new google.maps.LatLng(60.166757, 24.943705)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new google.maps.Map($(this.el)[0], myOptions)
    
    trafficLayer = new google.maps.TrafficLayer()
    trafficLayer.setMap(@map)

    weatherLayer = new google.maps.weather.WeatherLayer
      temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS

    weatherLayer.setMap(@map)

  render: =>
    this

