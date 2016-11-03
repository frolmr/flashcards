class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    locale =
      if current_user
        current_user.locale
      elsif params[:locale]
        session[:locale] = params[:locale]
      elsif session[:locale]
        session[:locale]
      elsif cookies[:locale]
        session[:locale] = cookies[:locale]
      else
        http_accept_language.compatible_language_from(I18n.available_locales)
      end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  private

  def not_authenticated
    redirect_to login_path
    flash[:danger] = t('authorization_danger_flash')
  end
end
