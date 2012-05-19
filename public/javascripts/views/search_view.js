(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.SearchView = (function(_super) {

    __extends(SearchView, _super);

    SearchView.name = 'SearchView';

    function SearchView() {
      this.currentPositionCallback = __bind(this.currentPositionCallback, this);

      this.render = __bind(this.render, this);

      this.initialize = __bind(this.initialize, this);
      return SearchView.__super__.constructor.apply(this, arguments);
    }

    SearchView.prototype.template = JST["templates/search"];

    SearchView.prototype.initialize = function() {
      this.$el.removeClass("map container-fluid");
      this.$el.addClass("container");
      if (navigator.geolocation) {
        console.log("Geolocation is supported");
        return navigator.geolocation.getCurrentPosition(this.currentPositionCallback);
      } else {
        return console.log("No geolocation support");
      }
    };

    SearchView.prototype.render = function() {
      console.log(this.$el);
      this.$el.html(this.template());
      return this;
    };

    SearchView.prototype.currentPositionCallback = function(position) {
      return sessionStorage.setItem("userLocation", JSON.stringify(position.coords));
    };

    SearchView.prototype.onSearchFormSubmit = function(event) {
      event.preventDefault();
      sessionStorage.setItem("userDestination", this.$('input[name=destination]').val());
      return Backbone.history.navigate("info", true);
    };

    SearchView.prototype.events = {
      "submit #search_form": "onSearchFormSubmit"
    };

    return SearchView;

  })(Backbone.View);

}).call(this);
