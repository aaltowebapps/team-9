((function(){var a={}.hasOwnProperty,b=function(b,c){function e(){this.constructor=b}for(var d in c)a.call(c,d)&&(b[d]=c[d]);return e.prototype=c.prototype,b.prototype=new e,b.__super__=c.prototype,b};App.Collections.WeatherStations=function(a){function c(){return c.__super__.constructor.apply(this,arguments)}return b(c,a),c.name="WeatherStations",c.prototype.url="/weather_stations.json",c.prototype.model=App.Models.WeatherStation,c}(Backbone.Collection)})).call(this)