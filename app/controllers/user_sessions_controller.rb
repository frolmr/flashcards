class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:session][:email], params[:session][:password])
      cookies[:locale] = I18n.locale = @user.locale
      redirect_back_or_to(root_path, success: t('login_successfull_flash'))
    else
      flash[:danger] = t('login_unsuccessfull_flash')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:success] = t('logout_successfull_flash')
  end
end
