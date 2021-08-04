class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :favorite_article]
                :authenticate_user!

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def show
    # render layout: false
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを変更しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path, notice:"アカウントを削除しました！"
  end

  def favorite_post
    @favorites = current_user.favorite_articles.all

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :icon, :icon_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
