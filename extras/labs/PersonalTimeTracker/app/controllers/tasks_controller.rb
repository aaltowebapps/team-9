class TasksController < ApplicationController
  respond_to :json

  def index
    @tasks = Task.all
    respond_with @tasks
  end

  def show
    @task = Task.find(params[:id])
    render("tasks/show.json.rabl", object: @task)
  end

  def create
    respond_with Task.create(params[:task])
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    respond_with(@task)
  end

  def destroy
    respond_with Task.destroy(params[:id])
  end

  def start
    @task = Task.find(params[:id])
    @task.start
    render("tasks/show.json.rabl", object: @task)
  end

  def stop
    @task = Task.find(params[:id])
    @task.stop
    render("tasks/show.json.rabl", object: @task)
  end

end
