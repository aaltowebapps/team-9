((function(){var a=function(a,b){return function(){return a.apply(b,arguments)}},b={}.hasOwnProperty,c=function(a,c){function e(){this.constructor=a}for(var d in c)b.call(c,d)&&(a[d]=c[d]);return e.prototype=c.prototype,a.prototype=new e,a.__super__=c.prototype,a};App.Models.User=function(b){function d(){return this.getLocationAsLatLng=a(this.getLocationAsLatLng,this),this.currentPositionCallback=a(this.currentPositionCallback,this),this.initialize=a(this.initialize,this),d.__super__.constructor.apply(this,arguments)}return c(d,b),d.name="User",d.prototype.localStorage=new Backbone.LocalStorage("User"),d.prototype.defaults={address:void 0,latitude:60.166591,longitude:24.943565,destination:"Helsinki"},d.prototype.initialize=function(){return navigator.geolocation?navigator.geolocation.getCurrentPosition(this.currentPositionCallback):console.log("No geolocation support")},d.prototype.currentPositionCallback=function(a){var b,c=this;return this.set({latitude:a.coords.latitude,longitude:a.coords.longitude}),b=function(a){return c.set({address:a[0].formatted_address.split(",")[0]}),c.save()},this.reverseGeoCode(this.getLocationAsLatLng(),b)},d.prototype.getLocationAsLatLng=function(){return new google.maps.LatLng(this.get("latitude"),this.get("longitude"))},d.prototype.reverseGeoCode=function(a,b){var c;return c=new google.maps.Geocoder,c.geocode({latLng:a},function(a,c){if(c===google.maps.GeocoderStatus.OK)return b(a)})},d.prototype.geoCode=function(a,b){return geocoder.geocode({address:a},function(a,c){return c===google.maps.GeocoderStatus.OK?b(a):alert("Geocode was not successful for the following reason: "+c)})},d}(Backbone.Model)})).call(this)