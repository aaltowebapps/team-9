(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Routers.Main = (function(_super) {

    __extends(Main, _super);

    Main.name = 'Main';

    function Main() {
      return Main.__super__.constructor.apply(this, arguments);
    }

    Main.prototype.routes = {
      "": "search",
      "info": "info",
      "map": "map"
    };

    Main.prototype.initialize = function() {
      return $("#dynamic").before(new App.Views.HeaderView().render().el);
    };

    Main.prototype.search = function() {
      var view;
      console.log("Rendering search view");
      view = new App.Views.SearchView({
        el: $("#dynamic")
      });
      return view.render();
    };

    Main.prototype.info = function() {
      var view;
      console.log("Rendering info view");
      view = new App.Views.InfoView({
        el: $("#dynamic")
      });
      return view.render();
    };

    Main.prototype.map = function() {
      var view;
      console.log("Rendering map view");
      view = new App.Views.MapView({
        el: $('#dynamic'),
        className: "map"
      });
      return view.render().el;
    };

    return Main;

  })(Backbone.Router);

}).call(this);
