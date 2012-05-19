(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  App.Models.Example = (function(_super) {

    __extends(Example, _super);

    Example.name = 'Example';

    function Example() {
      return Example.__super__.constructor.apply(this, arguments);
    }

    return Example;

  })(Backbone.Model);

}).call(this);
