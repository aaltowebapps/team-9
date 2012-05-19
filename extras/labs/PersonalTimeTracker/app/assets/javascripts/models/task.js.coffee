class PersonalTimeTracker.Models.Task extends Backbone.Model
  urlRoot: "/api/tasks"
  
  time: ->
    if @get("completed_at") && @get("started_at")
      (new Date(@get("completed_at")) - new Date(@get("started_at"))) / 1000
    else
      @get("completed_at")