class BecomeHostMailer < ApplicationMailer
  default from: ENV['gmail']

  def become_host(email)
    @email = email
    mail( to: ENV['gmail'],
          cc: ENV['trello_board'],
          subject: 'New Host Request for Crowdgate'
        )
  end

end
