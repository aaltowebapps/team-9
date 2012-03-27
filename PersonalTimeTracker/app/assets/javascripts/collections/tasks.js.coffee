class PersonalTimeTracker.Collections.Tasks extends Backbone.Collection

  model: PersonalTimeTracker.Models.Task
  url: '/api/tasks'

  averageTime: ->
    sum = @reduce((memo, value) ->
      memo + value.time()
    , 0)
    finished = @filter (task) ->
      task.time()?
    count = finished.length
    Math.round(sum / count)