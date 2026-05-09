class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    tasks = @current_user.tasks
    render json: tasks
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    render json: { message: 'Task deleted successfully' }
  end

  private

  def set_task
    @task = @current_user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Task not found' }, status: :not_found
  end

  def task_params
    params.permit(:title, :completed)
  end
end