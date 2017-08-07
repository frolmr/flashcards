class Home::UserSessionsController < ApplicationController
  include PageVisitActivity

  after_action :track_page_visit, only: [:new]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:session][:email], params[:session][:password])
      cookies[:locale] = I18n.locale = @user.locale
      redirect_back_or_to(root_path, success: t('.success'))
      @user.create_activity key: 'user.simple_auth', activity_type: 'user'
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
