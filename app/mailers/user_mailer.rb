class UserMailer < ActionMailer::Base
  default :from => "Info@wallstreet.ninja"
  
  def registration_request(register)
    @requester = register.user
    @institution = register.academy.owner
    mail(:to => @institution.email, :subject => "Registration Notification")
  end

  def moderator_registration_request(register)
    @requester = register.user
    @institution = register.academy.owner
    mail(:to => @institution.email, :subject => "Registration Notification")
  end
end
