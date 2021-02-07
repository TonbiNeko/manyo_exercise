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

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "アカウント情報を編集しました"
    else
      render :edit
    end
  end

  def show
    @tasks = @user.tasks.order_create_at_desc.page(params[:page]).per(10)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "アカウントを削除しました"
    else
      redirect_to admin_user_path(@user.id),notice: "管理者は最小１人必要です"
    end
  end

private
  def user_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_url, notice: '管理者以外アクセス出来ません' unless current_user.admin?
  end
end
