# Preview all emails at http://localhost:3000/rails/mailers/become_host_mailer
class BecomeHostMailerPreview < ActionMailer::Preview

  def become_host
    BecomeHostMailer.become_host('paul@crowdgate.us')
  end

  def schedule_appointment
    BecomeHostMailer.schedule_appointment('pjg5005@gmail.com')
  end

end
