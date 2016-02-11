module Users
  class PasswordsController < Devise::PasswordsController # :nodoc:
    include ApplicationHelper

    def new
      super
    end
  end
end
