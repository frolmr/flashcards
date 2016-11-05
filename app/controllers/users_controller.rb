class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  before_action :get_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      update_locale
      flash[:success] = t('.success')
      redirect_to root_path
    else
      flash.now[:danger] = t('.danger')
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      update_locale
      flash[:success] = t('.success')
      redirect_to user_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end

  def get_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def update_locale
    cookies[:locale] = I18n.locale = @user.locale
  end
end
