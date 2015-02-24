# Preview all emails at http://localhost:3000/rails/mailers/become_host_mailer
class BecomeHostMailerPreview < ActionMailer::Preview

  def become_host
    BecomeHostMailer.become_host('paul@crowdgate.us')
  end

end
