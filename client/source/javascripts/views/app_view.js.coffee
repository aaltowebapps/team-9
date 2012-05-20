class App.Views.AppView  extends App.Views.Page

  el: "body"

  initialize: (options) =>

    @header = new App.Views.HeaderView(el: $("#header"))

    @userDestination = sessionStorage.getItem("userDestination") || DEFAULT_LOCATION

    @infoView = new App.Views.InfoView()
    @infoView.parentView = @

    @mapView = new App.Views.MapView()
    @mapView.parentView = @


    super


  render: =>
    @infoView.render()
    @

  renderMap: =>
    @mapView.render()
    @