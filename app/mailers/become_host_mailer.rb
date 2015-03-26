class BecomeHostMailer < ApplicationMailer

  default from: ENV['gmail']

  def become_host(email)
    @email = email
    mail( to: ENV['trello_board'],
          subject: 'New Host Request for ' + @email
        )
  end

  def schedule_appointment(email)
    @email = email
    mail( to: @email,
          cc: 'paul@crowdgate.us',
          subject: 'Thanks for your interest in Crowdgate. You are almost ready to start listing your tailgates!'
        )
  end

end
