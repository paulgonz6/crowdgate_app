class BecomeHostMailer < ApplicationMailer
  default from: 'paul@crowdgate.us'

  def become_host(email)
    @email = email
    mail( to: "paul@crowdgate.us",
          cc: "paulgonzalez6+zhchbfgsqyaxpfbaq5f9@boards.trello.com",
          subject: 'New Host Request for Crowdgate'
        )
  end

end
