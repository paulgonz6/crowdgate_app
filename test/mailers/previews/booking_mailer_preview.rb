# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  def guest_receipt
    BookingMailer.guest_receipt(Booking.last)
  end

  def admin_booking_notification
    BookingMailer.admin_booking_notification(Booking.last)
  end

  def host_alert
    BookingMailer.host_alert(Booking.last)
  end

end
