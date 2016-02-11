module Users
  class RegistrationsController < Devise::RegistrationsController # :nodoc:
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
      devise_parameter_sanitizer.for(:sign_up).push(:email, :username, :first_name, :last_name, :age, :city, :state, :type, :institution_type, :institution_name)
    end

    def after_sign_up_path_for(resource)
      if resource.is_standard_user?
        user_profile_users_path
      else
        super
      end
    end
  end
end
