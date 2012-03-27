class PersonalTimeTracker.Views.TaskItem extends Backbone.View
  tagName: "tr"
  template: JST["tasks/item"]

  events:
    "click .delete"   : "delete"
    "click .start"    : "start"
    "click .complete" : "stop"

  initialize: -> 
    @model.on("reset", @render, this)

  render: ->
    @$el.html(@template(@model.toJSON()))
    @

  delete: (event) ->
    @model.destroy()
    @remove()

  start: (event) ->
    $.ajax(
      type: "POST"
      url: "/api/tasks/" + @model.get("id") + "/start"
    ).done (data) =>
      console.log @model
      @model.set(data)
      console.log @model
      @render()

  stop: (event) ->
    $.ajax(
      type: "POST"
      url: "/api/tasks/" + @model.get("id") + "/stop"
    ).done (data) =>
      @model.set(data)
      @render()



  Handlebars.registerHelper "round", (number) ->
    Math.round(number)