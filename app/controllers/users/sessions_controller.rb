# rubocop:disable Metrics/AbcSize
module Users
  # :nodoc:
  class SessionsController < Devise::SessionsController
    include ApplicationHelper

    def new
      super
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      if resource.active?
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash[:notice] = 'You Account disabled by AdminUser.'
        sign_out(resource)
        redirect_to :back
      end
    end
  end
end
