(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Collections.Examples = (function(_super) {

    __extends(Examples, _super);

    Examples.name = 'Examples';

    function Examples() {
      return Examples.__super__.constructor.apply(this, arguments);
    }

    Examples.prototype.url = '/';

    Examples.prototype.model = App.Models.Example;

    return Examples;

  })(Backbone.Collection);

}).call(this);
