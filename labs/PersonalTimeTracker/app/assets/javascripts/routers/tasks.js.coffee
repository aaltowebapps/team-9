class PersonalTimeTracker.Routers.Tasks extends Backbone.Router
  routes:
    '' : 'index'

  initialize: ->
    @collection = new PersonalTimeTracker.Collections.Tasks()
    @collection.fetch()


  index: ->
    view = new PersonalTimeTracker.Views.TasksIndex(collection: @collection)
    $('#tasks').html(view.render().el)