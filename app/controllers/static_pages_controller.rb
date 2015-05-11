class StaticPagesController < ApplicationController

  def landing_page
  end

  def how_it_works
  end

  def faq
  end

  def press
  end

  def promo_mailing_list
    # gb = Gibbon::API.new(ENV['mail_chimp_api'])

    # gb.lists.subscribe( {:id => ENV['mail_chimp_promo_list'],
    #                     :email => {:email => params[:email]},
    #                     :double_optin => false}
    #                   )
    respond_to do |format|
      format.js
    end
  end

end
