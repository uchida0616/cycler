class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show, :destroy]
  before_action :require_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user.id), notice: "アカウントを作成しました！"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def edit
  end

  def show
  end

  def index
    @users = User.all.includes(:articles)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to articles_path, notice: "あなたは管理者ではありません"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :icon, :icon_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
