class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
    if params[:name].present? && params[:status].present?
      @tasks = @tasks.search_with_name(params[:name]).search_with_status(params[:status])
    elsif params[:name].present?
      @tasks = @tasks.search_with_name (params[:name])
    elsif params[:status].present?
      @tasks = @tasks.search_with_status(params[:status])
      elsif params[:sort_expired]
        @tasks = Task.all.order_expiration_date_desc
      elsif params[:sort_priority]
        @tasks = Task.all.order(expiration_date: :asc)
      else
        @tasks = Task.all.order_create_at_desc
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :expiration_date, :status)
  end
end
