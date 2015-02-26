# TODO: I would try to go with rest routes (eg. resources) as most as possible here.

Rails.application.routes.draw do

# USER ROUTES =========================================================================
  devise_for :users, :controllers => { registrations: 'users/registrations' }


  # TODO: I would try to think in a resource here, the reason why thinking about
  # resources in Rails is helpful is because it kind of constraints you to make
  # sure you don't create gigantic controllers that handle more than on thing
  # A suggestion for a possible resource could be host:
  # (HostsController with a create action for example)

  #CREATE
  get '/become_host_sign_up', :controller   => 'users',
                              :action       => 'become_host_sign_up',
                              :as           => 'become_host'

  post '/host_request',       :controller   => 'users',
                              :action       => 'create_request_to_host'

  # READ
  get '/users',               :controller   => 'users',
                              :action       => 'index',
                              :as           => 'users'

  get '/users/:id',           :controller   => 'users',
                              :action       => 'show',
                              :as           => "user"

# STATIC PAGE ROUTES =========================================================================
  root "static_pages#landing_page"

  get '/static_pages/landing_page' => 'static_pages#landing_page'

  get '/faq',                 :controller => 'static_pages',
                              :action => 'faq',
                              :as => 'faq'

  get '/testing_page' => "static_pages#testing_page"

# EVENTS ROUTES ==============================================================================

  resources :events
  post '/events/bulk_create', :controller   => 'events',
                              :action       => 'bulk_create',
                              :as           => "events_bulk_create"


# TAILGATE ROUTES ============================================================================

  resources :tailgates
  resources :free_tailgates,                controller: 'tailgates', type: 'FreeTailgate'
  resources :paid_tailgates,                controller: 'tailgates', type: 'PaidTailgate'
  resources :packaged_tailgates,            controller: 'tailgates', type: 'PackagedTailgate'


# BOOKING ROUTES ============================================================================

  #CREATE - PAYMENT CONFIRMATION SCREEN
  get '/tailgates/:id/bookings/new',        :controller   => 'bookings',
                                            :action       => 'new',
                                            :as           => "new_booking"

  post '/bookings',                         :controller   => 'bookings',
                                            :action       => 'create',
                                            :as           => "bookings"

  # READ- RECEIPT
  get '/bookings',                          :controller   => 'bookings',
                                            :action       => 'index'

  get '/bookings/:id',                      :controller   => 'bookings',
                                            :action       => 'show',
                                            :as           => "booking"

  # UPDATE- FOR UPDATING WITH STRIPE TRANSACTION
  get '/bookings/:id/edit',                  :controller   => 'bookings',
                                             :action       => 'edit',
                                             :as           => "edit_booking"

  patch '/bookings/:id',                     :controller   => 'bookings',
                                             :action       => 'update'

  # DELETE- CANCEL TICKET (REFUND)
  delete '/bookings/:id',                    :controller   => 'bookings',
                                             :action       => 'destroy'

# REVIEW ROUTES ==============================================================================
  #CREATE
  get '/reviews/new',         :controller   => 'reviews',
                              :action       => 'new',
                              :as           => "new_review"

  post '/reviews',            :controller   => 'reviews',
                              :action       => 'create',
                              :as           => "reviews"

  # READ
  get '/reviews',             :controller   => 'reviews',
                              :action       => 'index'

  get '/reviews/:id',         :controller   => 'reviews',
                              :action       => 'show',
                              :as           => "review"

  # UPDATE
  get '/reviews/:id/edit',    :controller   => 'reviews',
                              :action       => 'edit',
                              :as           => "edit_review"

  patch '/reviews/:id',       :controller   => 'reviews',
                              :action       => 'update'

  # DELETE
  delete '/reviews/:id',      :controller   => 'reviews',
                              :action       => 'destroy'

# TEAM ROUTES ==============================================================================
  resources :teams
  get '/search_teams',        :controller   => 'teams',
                              :action       => 'search',
                              :as           => "search_teams"


end
