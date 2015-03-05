class BookingMailer < ApplicationMailer
  default from: ENV['gmail']

  def guest_receipt(booking)
    @booking = booking
    if @booking.buyer.present?
      email = @booking.buyer.email
    else
      email = @booking.email
    end

    mail( to: email,
          subject: 'Have fun at your tailgate! Confirmation #' + @booking.id.to_s
        )
  end

  def admin_booking_notification(booking)
    @booking = booking
    email = ENV['gmail']

    mail( to: email,
          subject: 'New Booking Just Created on Crowdgate'
        )
  end

  def host_alert(booking)
    @booking = booking
    email = @booking.tailgate.host.email

    mail( to: email,
          subject: 'Someone just booked your tailgate!'
        )
  end

end
