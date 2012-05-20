/**
 * Backbone localStorage Adapter
 * https://github.com/jeromegn/Backbone.localStorage
 */
(function(){function c(){return((1+Math.random())*65536|0).toString(16).substring(1)}function d(){return c()+c()+"-"+c()+"-"+c()+"-"+c()+"-"+c()+c()+c()}var a=this._,b=this.Backbone;b.LocalStorage=window.Store=function(a){this.name=a;var b=this.localStorage().getItem(this.name);this.records=b&&b.split(",")||[]},a.extend(b.LocalStorage.prototype,{save:function(){this.localStorage().setItem(this.name,this.records.join(","))},create:function(a){return a.id||(a.id=d(),a.set(a.idAttribute,a.id)),this.localStorage().setItem(this.name+"-"+a.id,JSON.stringify(a)),this.records.push(a.id.toString()),this.save(),a},update:function(b){return this.localStorage().setItem(this.name+"-"+b.id,JSON.stringify(b)),a.include(this.records,b.id.toString())||this.records.push(b.id.toString()),this.save(),b},find:function(a){return JSON.parse(this.localStorage().getItem(this.name+"-"+a.id))},findAll:function(){return a(this.records).chain().map(function(a){return JSON.parse(this.localStorage().getItem(this.name+"-"+a))},this).compact().value()},destroy:function(b){return this.localStorage().removeItem(this.name+"-"+b.id),this.records=a.reject(this.records,function(a){return a==b.id.toString()}),this.save(),b},localStorage:function(){return localStorage}}),b.LocalStorage.sync=window.Store.sync=b.localSync=function(a,b,c,d){var e=b.localStorage||b.collection.localStorage;typeof c=="function"&&(c={success:c,error:d});var f;switch(a){case"read":f=b.id!=undefined?e.find(b):e.findAll();break;case"create":f=e.create(b);break;case"update":f=e.update(b);break;case"delete":f=e.destroy(b)}f?c.success(f):c.error("Record not found")},b.ajaxSync=b.sync,b.getSyncMethod=function(a){return a.localStorage||a.collection&&a.collection.localStorage?b.localSync:b.ajaxSync},b.sync=function(a,c,d,e){return b.getSyncMethod(c).apply(this,[a,c,d,e])}})()