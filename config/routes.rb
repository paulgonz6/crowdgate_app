Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

# STATIC PAGE ROUTES =========================================================================
  get '/',                    :controller   => "static_pages",
                              :action       => "home"

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


# BOOKING ROUTES =============================================================================

  get('/tailgates/:id/booking/billing', { :controller => "bookings", :action => "billing" })
  get('/tailgates/:id/booking/receipt', { :controller => "bookings", :action => "receipt" })

# USER ROUTES ================================================================================

  #CREATE
  get '/users/new',           :controller   => 'users',
                              :action       => 'new',
                              :as           => "new_user"

  post '/users',              :controller   => 'users',
                              :action       => 'create',
                              :as           => "users"

  # READ
  get '/users',               :controller   => 'users',
                              :action       => 'index'

  get '/users/:id',           :controller   => 'users',
                              :action       => 'show',
                              :as           => "user"

  # UPDATE
  get '/users/:id/edit',      :controller   => 'users',
                              :action       => 'edit',
                              :as           => "edit_user"

  patch '/users/:id',         :controller   => 'users',
                              :action       => 'update'

  # DELETE
  delete '/users/:id',        :controller   => 'users',
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
