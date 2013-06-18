CountdownPoc::Application.routes.draw do
  resources :countdown_image_descriptors

  get "user_scheduled_emails/new"
  get "user_scheduled_emails/create"
  get "user_scheduled_emails/update"
  get "user_scheduled_emails/destroy"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  controller :countdown_users do
    get 'countdown_users/:id/setup_scheduled_email' => :setup_scheduled_email
    get 'countdown_users/:id/setup_calendar_event' => :setup_calendar_event
    post 'countdown_users/:id/calendar_event' => :calendar_event
    get 'countdown_users/:id/remove_scheduled_email' => :remove_scheduled_email
    post 'countdown_users/:id/schedule_email' => :schedule_email
  end


  resources :countdown_image

  resources :countdown_users
  
  resources :user_scheduled_emails

  
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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
