class App.Views.InfoView extends App.Views.Page
  
  template: JST["templates/info"]

  initialize: (options) =>

    @gmaps = options.model
    @user = options.user
    @weatherStations = new App.Collections.WeatherStations()
    @weatherStations.on("reset", @render, @)

    @userLocation = @user.get("address")
    @userDestination = @user.get("destination")
    request =
      origin: @userLocation
      destination: @userDestination
      travelMode: @gmaps.travelMode

    @gmaps.requestDirections request, (response, status) =>
      leg = response.routes[0].legs[0]
      @duration = leg.duration.text
      @start_address = leg.start_address
      @end_address = leg.end_address
      
      midpoint = leg.steps[Math.ceil(leg.steps.length/2)].start_location

      #steps = _.max leg.steps, (step) ->
        #step.distance.value
      #road_number = steps.instructions.match(/E[\d]+/) # Road numbers are in wrong format :(
      @weatherStations.fetch({ data: { latitude: midpoint.$a, longitude: midpoint.ab} })


      @render()

    super


  render: =>
    warnings = {}
    if @weatherStations.length > 0
      temperatureSum = @weatherStations.reduce (memo, ws) -> 
        memo + ws.get("observation_data").temperature
      , 0

      rainConditions = ["Dry weather", "Mild rain", "Moderate rain", "Heavy rain", "Mild snow", "Moderate snow", "Heavy snow"]

      warnings.precipitation = rainConditions[@weatherStations.at(0).get("observation_data").precipitation]
      warnings.temperatureAvg = Math.round(temperatureSum / @weatherStations.length * 10)/10
      warnings.minVisibility = (@weatherStations.min (ws) -> ws.get("observation_data").visibility).get("observation_data").visibility


    options = { duration: @duration, start_address: @start_address, end_address: @end_address, warnings: warnings }
    @$el.html(@template(options))
    @

