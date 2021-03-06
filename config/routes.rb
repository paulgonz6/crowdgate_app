Rails.application.routes.draw do

  devise_for  :users, :controllers =>
                          { registrations: 'users/registrations',
                            sessions: 'users/sessions' }

  post '/promo_mailing_list', :controller => 'static_pages',
                              :action => 'promo_mailing_list'

  resources   :users, :only => ['index', 'show', 'edit']

  get '/account',             :controller => 'users',
                              :action => 'account',
                              :as => 'account'


  resources   :tailgates do
    resources   :bookings
    resources   :reviews
  end

  resources   :free_tailgates,
                  controller: 'tailgates', type: 'FreeTailgate'

  resources   :paid_tailgates,
                  controller: 'tailgates', type: 'PaidTailgate'

  resources   :packaged_tailgates,
                  controller: 'tailgates', type: 'PackagedTailgate'

  resources   :teams
    post '/team_request',     :controller => 'teams',
                              :action => 'team_request'

  resources   :events
  resources   :hosts, :only => ['new', 'create']
  resources   :messages, :only => ['create', 'new']

# STATIC PAGE ROUTES =========================================================================
  root "static_pages#landing_page"

  get '/static_pages/landing_page' => 'static_pages#landing_page'

  get '/faq',                 :controller => 'static_pages',
                              :action => 'faq',
                              :as => 'faq'

  get '/press',               :controller => 'static_pages',
                              :action => 'press',
                              :as => 'press'

  get '/how_it_works',        :controller => 'static_pages',
                              :action => 'how_it_works',
                              :as => 'how_it_works'

  get '/testing_page' => "static_pages#testing_page"

  get '/tos' => "static_pages#tos", as: 'tos'

  get '/privacy' => "static_pages#privacy", as: 'privacy'



# EVENTS ROUTES ==============================================================================

  post '/events/bulk_create', :controller   => 'events',
                              :action       => 'bulk_create',
                              :as           => "events_bulk_create"


# TEAM ROUTES ==============================================================================
  get '/search_teams',        :controller   => 'teams',
                              :action       => 'search',
                              :as           => "search_teams"


end
