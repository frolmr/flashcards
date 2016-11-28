class Home::UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:session][:email], params[:session][:password])
      cookies[:locale] = I18n.locale = @user.locale
      redirect_back_or_to(root_path, success: t('.success'))
    else
      flash[:danger] = t('.danger')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:success] = t('.success')
  end
end
