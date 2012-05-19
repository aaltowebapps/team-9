(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Views.HeaderView = (function(_super) {

    __extends(HeaderView, _super);

    HeaderView.name = 'HeaderView';

    function HeaderView() {
      this.render = __bind(this.render, this);
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.template = JST["templates/header"];

    HeaderView.prototype.render = function() {
      this.$el.html(this.template());
      return this;
    };

    HeaderView.prototype.onSearchFormSubmit = function(event) {
      console.log(this.$('input[name=destination]').val());
      event.preventDefault();
      sessionStorage.setItem("userDestination", this.$('input[name=destination]').val());
      Backbone.history.fragment = null;
      return Backbone.history.navigate("info", true);
    };

    HeaderView.prototype.events = {
      "submit #header_search_form": "onSearchFormSubmit"
    };

    return HeaderView;

  })(Backbone.View);

}).call(this);
