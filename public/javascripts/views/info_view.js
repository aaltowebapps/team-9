((function(){var a=function(a,b){return function(){return a.apply(b,arguments)}},b={}.hasOwnProperty,c=function(a,c){function e(){this.constructor=a}for(var d in c)b.call(c,d)&&(a[d]=c[d]);return e.prototype=c.prototype,a.prototype=new e,a.__super__=c.prototype,a};App.Views.InfoView=function(b){function d(){return this.render=a(this.render,this),this.initialize=a(this.initialize,this),d.__super__.constructor.apply(this,arguments)}return c(d,b),d.name="InfoView",d.prototype.template=JST["templates/info"],d.prototype.initialize=function(a){var b,c=this;return this.gmaps=a.model,this.user=a.user,this.userLocation=this.user.get("address"),this.userDestination=this.user.get("destination"),b={origin:this.userLocation,destination:this.userDestination,travelMode:this.gmaps.travelMode},this.gmaps.requestDirections(b,function(a,b){var d;return d=a.routes[0].legs[0],c.duration=d.duration.text,c.start_address=d.start_address,c.end_address=d.end_address,c.render()}),d.__super__.initialize.apply(this,arguments)},d.prototype.render=function(){return this.$el.html(this.template({duration:this.duration,start_address:this.start_address,end_address:this.end_address})),this},d}(App.Views.Page)})).call(this)