class UserMailer < ActionMailer::Base
  default :from => "testatdev@gmail.com"
  
  def registration_request(register)
    @requester = register.standard
    @institution = register.academy.institution
    mail(:to => @institution.email, :subject => "Registration Notification")
  end
end
