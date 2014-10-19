Felcv::Application.routes.draw do

  #index
  get "welcome/index"

  #users
  get '/download_pdf(.:format)' => 'users#index_pdf', :as=>'index_pdf'

  devise_for :users,:controllers => { :registrations =>'users'}

  get 'users/sign_up' => 'users#new', :as => 'new_user'
  post 'users/create' => 'users#create', :as => 'create_user'
  get 'users/index/:id' => 'users#index', :as => 'users' 
  get 'users/view/:id' => 'users#show', :as => 'user' 
  post 'users/edit_status' => 'users#edit_status', :as => 'edit_user_status' 
  get 'users/edit' => 'users#edit', :as => 'edit_user' 
  post 'users/update' => 'users#update', :as => 'update_user' 
  get 'users/edit_password' => 'users#edit_password', :as => 'edit_password_user'  
  post 'users/update_password' => 'users#update_password', :as => 'update_password' 
  get 'users/upload_cert/:id' => 'users#upload_cert', :as => 'upload_cert'
  post 'users/save_cert' => 'users#save_cert', :as => 'save_cert'
  
  #cases
  get 'cases/index' => 'cases#index', :as => 'cases'
  get 'cases/index_mine' => 'cases#index_mine', :as => 'cases_mine'
  get 'cases/view/:id' => 'cases#show', :as => 'case'
  get 'cases/new' => 'cases#new', :as => 'new_case'
  post 'cases/create' => 'cases#create', :as => 'create_case'
  get 'cases/edit/:id' => 'cases#edit', :as => 'edit_case'
  get 'cases/update/:id' => 'cases#update', :as => 'update_case'
  get 'cases/simple_search' => 'cases#simple_search', :as => 'simple_search'
  get 'cases/advanced_search' => 'cases#advanced_search', :as => 'advanced_search'

  #complaint
  get 'complaints/view/:id' => 'complaints#show', :as => 'complaint'
  get 'complaints/new/:case_id' => 'complaints#new', :as => 'new_complaint'
  post 'complaints/create' => 'complaints#create', :as => 'create_complaint'
  get 'complaints/edit/:id' => 'complaints#edit', :as => 'edit_complaint'
  post 'complaints/update' => 'complaints#update', :as => 'update_complaint'
  get 'complaints/private_key/:id' => 'complaints#private_key', :as => 'private_key'
  post 'complaints/sign_complaint' => 'complaints#sign_complaint', :as => 'sign_complaint'
  

   #direct_actions
  get 'direct_actions/view/:id' => 'direct_actions#show', :as => 'direct_action'
  get 'direct_actions/new/:case_id' => 'direct_actions#new', :as => 'new_direct_action'
  post 'direct_actions/create' => 'direct_actions#create', :as => 'create_direct_action'
  get 'direct_actions/edit/:id' => 'direct_actions#edit', :as => 'edit_direct_action'
  post 'direct_actions/update' => 'direct_actions#update', :as => 'update_direct_action'
  get 'direct_actions/key_pass/:id' => 'direct_actions#key_pass', :as => 'key_pass_direct_action'
  get 'direct_actions/sign/:id' => 'direct_actions#sign', :as => 'sign_direct_action'
  get 'direct_actions/create_item' => 'direct_actions#create_item', :as => 'create_item'
  get 'direct_actions/edit_item' => 'direct_actions#edit_item', :as => 'edit_item'
  get 'direct_actions/destroy_item/:id_item' => 'direct_actions#destroy_item', :as => 'destroy_item'
  post 'direct_action/save' => 'direct_actions#save_direct_action', :as => 'save_direct_action'
  

  #people
  get 'people/index/:id' => 'people#index', :as => 'people'
  get 'people/view/:id' => 'people#show', :as => 'person'
  get 'people/new/:case_id' => 'people#new', :as => 'new_person'
  post 'people/create' => 'people#create', :as => 'create_person'
  get 'people/continue_new/:link_id' => 'people#continue_new', :as => 'continue_new'
  post 'people/continue_create' => 'people#continue_create', :as => 'continue_create_person'
  get 'people/edit/:id' => 'people#edit', :as => 'edit_person'
  post 'people/update' => 'people#update', :as => 'update_person'
  get 'people/destroy/:id' => 'people#destroy', :as => 'destroy_person'

  #interview
  get 'interviews/view/:id' => 'interviews#show', :as => 'interview'
  get 'interviews/new/:case_id' => 'interviews#new', :as => 'new_interview'
  post 'interviews/create' => 'interviews#create', :as => 'create_interview'
  post 'interviews/create_question' => 'interviews#create_question', :as => 'create_question'
  get 'interviews/edit/:id' => 'interviews#edit', :as => 'edit_interview'
  post 'interviews/update/:id' => 'interviews#update', :as => 'update_interview'
  get 'interviews/destroy/:id' => 'interviews#destroy', :as => 'destroy_interview'
  get 'interviews/destroy_question/:id' => 'interviews#destroy_question', :as => 'destroy_question'
  get 'interviews/edit_question/:id' => 'interviews#edit_question', :as => 'edit_question'
  get 'interviews/sign/:id' => 'interviews#sign', :as => 'sign_interview'
  get 'interviews/key_pass/:id' => 'interviews#key_pass', :as => 'key_pass_interview'

  #conclusions
  get 'conclusions/view/:id' => 'conclusions#show', :as => 'conclusion'
  get 'conclusions/new/:case_id' => 'conclusions#new', :as => 'new_conclusion'
  post 'conclusions/create' => 'conclusions#create', :as => 'create_conclusion'
  get 'conclusions/edit/:id' => 'conclusions#edit', :as => 'edit_conclusion'
  post 'conclusions/update/:id' => 'conclusions#update', :as => 'update_conclusion'

  #stations
  get 'stations/index' => 'stations#index', :as => 'stations'
  get 'stations/view/:id' => 'stations#show', :as => 'station'
  get 'stations/new' => 'stations#new', :as => 'new_station'
  post 'stations/create' => 'stations#create', :as => 'create_station'
  get 'stations/edit/:id' => 'stations#edit', :as => 'edit_station'
  post 'stations/update' => 'stations#update', :as => 'update_station'
  get 'stations/destroy/:id' => 'stations#destroy', :as => 'destroy_station'

  #reports
  get 'reports/new' => 'reports#new', :as => 'new_report'
  post 'reports/create' => 'reports#create', :as => 'create_report'
  get 'reports/second' => 'reports#second', :as => 'second_report'
  get  'reports/third' => 'reports#third', :as => 'third_report'

  root 'welcome#index'
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
