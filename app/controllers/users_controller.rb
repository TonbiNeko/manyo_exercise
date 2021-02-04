class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @user = current_user
    @tasks = current_user.tasks.order_create_at_desc.page(params[:page]).per(10)
  end

  def new
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
