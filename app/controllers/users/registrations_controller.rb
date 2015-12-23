class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def create
    super
  end

  def new
    super
  end

  def edit
    super
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:email, :username, :first_name, :last_name, :city, :state)
  end
end
