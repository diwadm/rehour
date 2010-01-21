class UserMailer < ActionMailer::Base
  include ApplicationHelper
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Your time reporting account'
    @body[:url]  = "http://#{site_url}/activate/#{user.activation_code}"
  end
  
  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "reHour <do-not-reply@rehour.com>"
    @subject     = ""
    @sent_on     = Time.now
    @body[:user] = user
  end
end
