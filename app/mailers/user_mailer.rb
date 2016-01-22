class UserMailer < ActionMailer::Base
  default :from => "Info@wallstreet.ninja"
  
  def registration_request(register)
    @requester = register.standard
    @institution = register.academy.institution
    mail(:to => @institution.email, :subject => "Registration Notification")
  end
end
