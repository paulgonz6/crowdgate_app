class BookingMailer < ApplicationMailer
  default from: 'paul@crowdgate.us'

  def receipt_email(booking)
    @booking = booking
    mail(to: "pjg5005@gmail.com", subject: 'Welcome to My Awesome Site')
  end

end