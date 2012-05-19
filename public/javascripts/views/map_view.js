(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.MapView = (function(_super) {

    __extends(MapView, _super);

    MapView.name = 'MapView';

    function MapView() {
      this.toggleWeatherLayer = __bind(this.toggleWeatherLayer, this);

      this.toggleTrafficLayer = __bind(this.toggleTrafficLayer, this);

      this.toggleOverlays = __bind(this.toggleOverlays, this);

      this.setupPlaces = __bind(this.setupPlaces, this);

      this.currentPositionCallback = __bind(this.currentPositionCallback, this);

      this.toggleLayer = __bind(this.toggleLayer, this);

      this.renderMap = __bind(this.renderMap, this);

      this.render = __bind(this.render, this);

      this.initialize = __bind(this.initialize, this);
      return MapView.__super__.constructor.apply(this, arguments);
    }

    MapView.prototype.template = JST["templates/map"];

    MapView.prototype.initialize = function(options) {
      var userLocationArray;
      this.$el.removeClass("container");
      this.$el.addClass("map container-fluid");
      userLocationArray = JSON.parse(sessionStorage.getItem("userLocation"));
      this.userLocation = new google.maps.LatLng(userLocationArray.latitude, userLocationArray.longitude);
      return this.userDestination = sessionStorage.getItem("userDestination");
    };

    MapView.prototype.render = function() {
      this.$el.html(this.template());
      this.renderMap();
      return this;
    };

    MapView.prototype.renderMap = function() {
      var myOptions;
      myOptions = {
        zoom: 13,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: this.userLocation
      };
      this.map = new google.maps.Map($("#map_canvas")[0], myOptions);
      this.trafficLayer = new google.maps.TrafficLayer();
      this.toggleLayer(this.trafficLayer);
      this.weatherLayer = new google.maps.weather.WeatherLayer({
        temperatureUnits: google.maps.weather.TemperatureUnit.CELCIUS
      });
      this.toggleLayer(this.weatherLayer);
      this.setupPlaces();
      return $(".toggle-traffic, .toggle-conditions, .toggle-places").button("toggle");
    };

    MapView.prototype.toggleLayer = function(layer) {
      return layer.setMap(layer.getMap() != null ? null : this.map);
    };

    MapView.prototype.currentPositionCallback = function(position) {};

    MapView.prototype.setupPlaces = function() {
      var directionsRenderer, directionsService, request,
        _this = this;
      request = {
        location: this.userLocation,
        radius: "5000",
        types: ["gas_station"]
      };
      this.placesLayer = new google.maps.places.PlacesService(this.map);
      this.placesLayer.search(request, function(results, status) {
        var place, result, _i, _len, _results;
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          _this.markersArray = [];
          _results = [];
          for (_i = 0, _len = results.length; _i < _len; _i++) {
            result = results[_i];
            place = result;
            _results.push(_this.markersArray.push(new google.maps.Marker({
              position: result.geometry.location,
              map: _this.map,
              title: result.name,
              icon: '/img/gas_station.png'
            })));
          }
          return _results;
        } else {
          return console.log(status);
        }
      });
      directionsRenderer = new google.maps.DirectionsRenderer();
      directionsRenderer.setMap(this.map);
      directionsRenderer.setPanel(document.getElementById("directionsPanel"));
      directionsService = new google.maps.DirectionsService();
      request = {
        origin: this.userLocation,
        destination: this.userDestination,
        travelMode: google.maps.DirectionsTravelMode.DRIVING,
        unitSystem: google.maps.DirectionsUnitSystem.METRIC
      };
      return directionsService.route(request, function(response, status) {
        if (status === google.maps.DirectionsStatus.OK) {
          return directionsRenderer.setDirections(response);
        } else {
          return alert("Error: " + status);
        }
      });
    };

    MapView.prototype.toggleOverlays = function() {
      var marker, _i, _len, _ref, _results;
      _ref = this.markersArray;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        marker = _ref[_i];
        _results.push(marker.setMap(marker.getMap() != null ? null : this.map));
      }
      return _results;
    };

    MapView.prototype.toggleTrafficLayer = function() {
      return this.toggleLayer(this.trafficLayer);
    };

    MapView.prototype.toggleWeatherLayer = function() {
      return this.toggleLayer(this.weatherLayer);
    };

    MapView.prototype.events = {
      "click .toggle-traffic": "toggleTrafficLayer",
      "click .toggle-conditions": "toggleWeatherLayer",
      "click .toggle-places": "toggleOverlays"
    };

    return MapView;

  })(Backbone.View);

}).call(this);
