class ApplicationController < ActionController::Base # :nodoc:
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  #->Prelang (user_login:devise)
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :username, :email, :password,
        :password_confirmation, :remember_me)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(
        :login, :username, :email,
        :password, :remember_me)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email,
               :password, :password_confirmation,
               :current_password)
    end
  end

  private

  #-> Prelang (user_login:devise)
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      fallback_redirect = if request.env['HTTP_REFERER']
                            :back
                          elsif defined?(root_path)
                            root_path
                          else
                            '/'
                          end
      msg = 'You must be signed in to view this page.'
      redirect_to fallback_redirect, flash: { error: msg }
    end
  end
end
