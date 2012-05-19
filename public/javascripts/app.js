(function() {

  window.App = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    init: function() {
      console.log("Initialized Backbone application");
      new App.Routers.Main;
      return Backbone.history.start();
    }
  };

  $(document).ready(function() {
    return App.init();
  });

}).call(this);
