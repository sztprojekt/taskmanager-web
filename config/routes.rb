Rails.application.routes.draw do

  authenticate :user do
    get 'admin'  => 'admin#index'
    get 'user'  =>  'user#read'
  end

  authenticated :user do
    root to: 'admin#index', as: 'admin_index'
    get 'tasks' => 'task#index'
    post 'task' => 'task#create'
    get 'task/(:id)' => 'task#read'
    put 'task' => 'task#update'
    delete 'task/:id' => 'task#delete'
    put 'task/complete/:task_id' => 'task#complite'
  end

  unauthenticated :user do
    root to: 'site#index', as: 'unauthenticated'
    get '/yo'   =>  'yo#google'
    get 'auth/:provider/callback' => 'auth#google_auth'
    get '/calendar'               => 'yo#calendar'
  end

  post 'api/login' => 'api#login'

  get 'api/tasks'             => 'task_api#all'
  get 'api/task/:id'          => 'task_api#one'
  post 'api/task'             => 'task_api#create'
  put 'api/task'              => 'task_api#update'
  delete 'api/task/:id'           => 'task_api#delete'
  put 'api/task/status'       => 'task_api#update_status'
  post 'api/google/auth'      => 'auth_api#google_auth'

  root 'site#index'

  devise_for :users, :controllers => { registrations: 'registration', sessions: 'session' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
