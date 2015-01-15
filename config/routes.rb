Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get('/', { :controller => "static_pages", :action => "home" })

  get('/events/new', { :controller => "events", :action => "new" })
  get('/events/add', { :controller => "events", :action => "add" })
  get('/events/index', { :controller => "events", :action => "index" })

  get('/events/delete/:id', { :controller => "events", :action => "delete" })
  get('/events/destroy/:id', { :controller => "events", :action => "destroy" })

  get('/events/edit/:id', { :controller => "events", :action => "edit" })
  get('/events/save', { :controller => "events", :action => "save" })

  get('/tailgates/index', { :controller => "tailgates", :action => "index" })
  get('/tailgates/show/:id', { :controller => "tailgates", :action => "show" })
  get('/new_tailgate', { :controller => "tailgates", :action => "new" })
  get('/create_tailgate', { :controller => "tailgates", :action => "process_form" })

  get 'confirm' => 'tailgates#confirm_purchase'
  get 'receipt' => 'tailgates#receipt'


  get 'login' => 'sessions#new'

  get 'signup' => 'users#new'

  get 'review' => 'reviews#new'

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
