(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.InfoView = (function(_super) {

    __extends(InfoView, _super);

    InfoView.name = 'InfoView';

    function InfoView() {
      this.render = __bind(this.render, this);

      this.initialize = __bind(this.initialize, this);
      return InfoView.__super__.constructor.apply(this, arguments);
    }

    InfoView.prototype.template = JST["templates/info"];

    InfoView.prototype.initialize = function(options) {
      var request, service, userDestination, userLocation, userLocationArray,
        _this = this;
      console.log(sessionStorage);
      userLocationArray = JSON.parse(sessionStorage.getItem("userLocation"));
      userLocation = new google.maps.LatLng(userLocationArray.latitude, userLocationArray.longitude);
      userDestination = sessionStorage.getItem("userDestination");
      request = {
        origin: userLocation,
        destination: userDestination,
        travelMode: google.maps.TravelMode.DRIVING
      };
      service = new google.maps.DirectionsService();
      service.route(request, function(response, status) {
        var leg;
        console.log(response, status);
        if (status === "OK") {
          leg = response.routes[0].legs[0];
          _this.duration = leg.duration.text;
          _this.start_address = leg.start_address;
          _this.end_address = leg.end_address;
          return _this.render();
        } else {
          return console.log(status);
        }
      });
      this.$el.removeClass("map container-fluid");
      return this.$el.addClass("container");
    };

    InfoView.prototype.render = function() {
      this.$el.html(this.template({
        duration: this.duration,
        start_address: this.start_address,
        end_address: this.end_address
      }));
      return this;
    };

    return InfoView;

  })(Backbone.View);

}).call(this);
