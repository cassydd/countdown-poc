class UserMailer < ActionMailer::Base
  default from: "chris.stratton@gmail.com"
  
  def notification_email(countdown_user)
    @countdown_user = countdown_user
    mail(to: countdown_user.user_scheduled_email.email_address, subject: "Notification email for your countdown timer [#{countdown_user.timer_title}].")
  end 
end
