Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  # devise_scope :user do

  # # USER SESSIONS=================================================
  #   get     '/users/sign_in',       :to => 'devise/sessions#new',
  #                                   :as => 'new_user_session'

  #   get     '/users/sign_in',       :to => 'devise/sessions#create',
  #                                   :as => 'user_session'

  #   delete  '/users/sign_out',      :to => 'devise/sessions#destroy',
  #                                   :as => 'destroy_user_session'

  # # USER PASSWORD UPDATES=================================================
  #   post    '/users/password',      :to => 'devise/passwords#create',
  #                                   :as => 'user_password'

  #   get     '/users/password/new',  :to => 'devise/passwords#new',
  #                                   :as => 'new_user_password'

  #   get     '/users/password/edit', :to => 'devise/passwords#edit',
  #                                   :as => 'edit_user_password'

  #   patch   '/users/password',      :to => 'devise/passwords#update'

  #   put     '/users/password',      :to => 'devise/passwords#update'


  # # USER CREATION=================================================
  #   get     '/users/cancel',        :to => 'devise/registrations#cancel',
  #                                   :as => 'cancel_user_registration'

  #   delete  '/users',               :to => 'devise/registrations#destroy'

  #   post    '/users',               :to => 'devise/registrations#create',
  #                                   :as => 'user_registration'

  #   get     '/users/sign_up',       :to => 'devise/registrations#new',
  #                                   :as => 'new_user_registration'

  #   get     '/users/edit',          :to => 'devise/registrations#edit',
  #                                   :as => 'edit_user_registration'

  #   patch   '/users',               :to => 'devise/registrations#update'

  #   put     '/users',               :to => 'devise/registrations#update'
  # end

# STATIC PAGE ROUTES =========================================================================
  root "static_pages#landing_page"

  get '/static_pages/landing_page' => 'static_pages#landing_page'

# EVENTS ROUTES ==============================================================================

  #CREATE
  get '/events/new',          :controller   => 'events',
                              :action       => 'new',
                              :as           => "new_event"

  post '/events',             :controller   => 'events',
                              :action       => 'create',
                              :as           => "events"

  post '/events/bulk_create', :controller   => 'events',
                              :action       => 'bulk_create',
                              :as           => "events_bulk_create"

  # READ
  get '/events',              :controller   => 'events',
                              :action       => 'index'

  get '/events/:id',          :controller   => 'events',
                              :action       => 'show',
                              :as           => "event"

  # UPDATE
  get '/events/:id/edit',     :controller   => 'events',
                              :action       => 'edit',
                              :as           => "edit_event"

  patch '/events/:id',        :controller   => 'events',
                              :action       => 'update'

  # DELETE
  delete '/events/:id',       :controller   => 'events',
                              :action       => 'destroy'

# TAILGATE ROUTES ============================================================================

  #CREATE
  get '/tailgates/new',       :controller   => 'tailgates',
                              :action       => 'new',
                              :as           => "new_tailgate"

  post '/tailgates',          :controller   => 'tailgates',
                              :action       => 'create',
                              :as           => "tailgates"

  # READ
  get '/tailgates',           :controller   => 'tailgates',
                              :action       => 'index'

  get '/tailgates/:id',       :controller   => 'tailgates',
                              :action       => 'show',
                              :as           => "tailgate"

  # UPDATE
  get '/tailgates/:id/edit',  :controller   => 'tailgates',
                              :action       => 'edit',
                              :as           => "edit_tailgate"

  patch '/tailgates/:id',     :controller   => 'tailgates',
                              :action       => 'update'

  # DELETE
  delete '/tailgates/:id',    :controller   => 'tailgates',
                              :action       => 'destroy'


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


# USER ROUTES ================================================================================

  #CREATE
  get '/become_host_sign_up', :controller   => 'users',
                              :action       => 'become_host_sign_up',
                              :as           => 'become_host'

  # READ
  get '/users',               :controller   => 'users',
                              :action       => 'index',
                              :as           => 'users'

  get '/users/:id',           :controller   => 'users',
                              :action       => 'show',
                              :as           => "user"

  # get '/users/:id/tailgates', :controller   => 'users',
  #                             :action       => 'tailgates_index'

  # # UPDATE
  # get '/users/:id/edit',      :controller   => 'users',
  #                             :action       => 'edit',
  #                             :as           => "edit_user"

  # patch '/users/:id',         :controller   => 'users',
  #                             :action       => 'update'

  # # DELETE
  # delete '/users/:id',        :controller   => 'users',
  #                             :action       => 'destroy'


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

  get '/search_teams',        :controller   => 'teams',
                              :action       => 'search',
                              :as           => "search_teams"

  #CREATE
  get '/teams/new',           :controller   => 'teams',
                              :action       => 'new',
                              :as           => "new_team"

  post '/teams',              :controller   => 'teams',
                              :action       => 'create',
                              :as           => "teams"

  # READ
  get '/teams',               :controller   => 'teams',
                              :action       => 'index'

  get '/teams/:id',           :controller   => 'teams',
                              :action       => 'show',
                              :as           => "team"

  # UPDATE
  get '/teams/:id/edit',      :controller   => 'teams',
                              :action       => 'edit',
                              :as           => "edit_team"

  patch '/teams/:id',         :controller   => 'teams',
                              :action       => 'update'

  # DELETE
  delete '/teams/:id',        :controller   => 'teams',
                              :action       => 'destroy'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
