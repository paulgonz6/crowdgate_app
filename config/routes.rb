Rails.application.routes.draw do

  devise_for  :users, :controllers =>
                          { registrations: 'users/registrations',
                            sessions: 'users/sessions' }

  resources   :users, :only => ['index', 'show']
  resources   :hosts, :only => ['new', 'create']

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
  resources   :events

# STATIC PAGE ROUTES =========================================================================
  root "static_pages#landing_page"

  get '/static_pages/landing_page' => 'static_pages#landing_page'

  get '/faq',                 :controller => 'static_pages',
                              :action => 'faq',
                              :as => 'faq'

  get '/how_it_works',        :controller => 'static_pages',
                              :action => 'how_it_works',
                              :as => 'how_it_works'

  get '/testing_page' => "static_pages#testing_page"



# EVENTS ROUTES ==============================================================================

  post '/events/bulk_create', :controller   => 'events',
                              :action       => 'bulk_create',
                              :as           => "events_bulk_create"


# TEAM ROUTES ==============================================================================
  get '/search_teams',        :controller   => 'teams',
                              :action       => 'search',
                              :as           => "search_teams"


end
