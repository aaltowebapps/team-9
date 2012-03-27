class PersonalTimeTracker.Views.TasksIndex extends Backbone.View

  template: JST['tasks/index']

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @render, this)


  render: =>
    @$el.html(@template(tasks: @collection.toJSON()))
    @collection.each(@appendTask)
    @

  appendTask: (model) =>
    view = new PersonalTimeTracker.Views.TaskItem({ model: model })
    @$('tbody').append(view.render().el)

  create: (event) ->
    event.preventDefault()
    attributes = 
      title: $("#task_title").val()
    @collection.create attributes,
      error: -> console.log("Failure")
      wait: true

  events:
    "click #create_task" : "create"