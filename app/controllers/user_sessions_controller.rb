class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, success: 'Успешный вход')
    else
      flash.now[:danger] = 'Не удалось войти'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:success] = 'Успешный выход'
  end
end
