((function(){var a=function(a,b){return function(){return a.apply(b,arguments)}},b={}.hasOwnProperty,c=function(a,c){function e(){this.constructor=a}for(var d in c)b.call(c,d)&&(a[d]=c[d]);return e.prototype=c.prototype,a.prototype=new e,a.__super__=c.prototype,a};App.Models.GMaps=function(b){function d(){return this.initialize=a(this.initialize,this),d.__super__.constructor.apply(this,arguments)}return c(d,b),d.name="GMaps",d.prototype.default_location="helsinki",d.prototype.zoom=13,d.prototype.mapTypeId=google.maps.MapTypeId.ROADMAP,d.prototype.travelMode=google.maps.DirectionsTravelMode.DRIVING,d.prototype.unitSystem=google.maps.DirectionsUnitSystem.METRIC,d.prototype.placeRadius=1e4,d.prototype.placeTypes=["gas_station","lodging","car_repair"],d.prototype.initialize=function(){return this.directionsService=new google.maps.DirectionsService},d.prototype.requestDirections=function(a,b){var c=this;return this.directionsService.route(a,function(a,c){if(c===google.maps.DirectionsStatus.OK)return b(a,c)})},d}(Backbone.Model)})).call(this)