class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :name, :email).page(params[:page]).per(10)
  end

  def new
  @user = User.new
  end

  def edit
  end

  def show
    @tasks = @user.tasks.order_create_at_desc.page(params[:page]).per(10)
  end

  def destroy
    @user.destroy
    redirect_to admin_user_path, notice: "アカウントを削除しました"
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_url, notice: '管理者以外アクセス出来ません' unless current_user.admin?
  end
end
