class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @tasks = Task.all
      if params[:name].present? && params[:status].present?
        @tasks = @tasks.search_with_name(params[:name]).search_with_status(params[:status]).page(params[:page]).per(10)
      elsif params[:name].present?
        @tasks = @tasks.search_with_name(params[:name]).page(params[:page]).per(10)
      elsif params[:status].present?
        @tasks = @tasks.search_with_status(params[:status]).page(params[:page]).per(10)
      elsif params[:priority].present?
        @tasks = @tasks.search_with_priority(params[:priority]).page(params[:page]).per(10)
      elsif params[:sort_expired]
        @tasks = Task.all.order_expiration_date_desc.page(params[:page]).per(10)
      elsif params[:sort_priority]
        @tasks = @tasks.sort_priority.page(params[:page]).per(10)
      elsif params[:sort_date_and_status]
        @tasks = Task.all.sort_date_and_status.page(params[:page]).per(10)
      else
        @tasks = Task.all.order_create_at_desc.page(params[:page]).per(10)
      end
    else
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:name, :description, :expiration_date, :status, :priority)
  end
end
