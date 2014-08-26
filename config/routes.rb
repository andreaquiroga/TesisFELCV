Felcv::Application.routes.draw do

  resources :locations

  devise_for :users,:controllers => { :registrations =>'registration'}
  get "welcome/index"
  get "officials/new/:user_id" => "officials#new", :as => "new_official"
  post "officials/create" => "officials#create", :as => "create_official"

  #cases
  get 'cases/index' => 'cases#index', :as => 'cases'
  get 'cases/view/:id' => 'cases#show', :as => 'case'
  get 'cases/new' => 'cases#new', :as => 'new_case'
  post 'cases/create' => 'cases#create', :as => 'create_case'
  get 'cases/edit/:id' => 'cases#edit', :as => 'edit_case'
  get 'cases/update/:id' => 'cases#update', :as => 'update_case'
  get 'cases/destroy/:id' => 'cases#destroy', :as => 'destroy_case'
  get 'cases/simple_search' => 'cases#simple_search', :as => 'simple_search'
  get 'cases/advanced_search' => 'cases#advanced_search', :as => 'advanced_search'

  #complaint
  get 'complaints/index' => 'complaints#index', :as => 'complaints'
  get 'complaints/view/:id' => 'complaints#show', :as => 'complaint'
  get 'complaints/new/:case_id' => 'complaints#new', :as => 'new_complaint'
  post 'complaints/create' => 'complaints#create', :as => 'create_complaint'
  get 'complaints/edit/:id' => 'complaints#edit', :as => 'edit_complaint'
  post 'complaints/update' => 'complaints#update', :as => 'update_complaint'
  get 'complaints/destroy/:id' => 'complaints#destroy', :as => 'destroy_complaint'
  get 'complaints/key_pass/:id' => 'complaints#key_pass', :as => 'key_pass'
  get 'complaints/sign/:id' => 'complaints#sign', :as => 'sign_complaint'

  #people
  get 'people/index' => 'people#index', :as => 'people'
  get 'people/view/:id' => 'people#show', :as => 'person'
  get 'people/new/:case_id' => 'people#new', :as => 'new_person'
  post 'people/create' => 'people#create', :as => 'create_person'
  get 'people/continue_new/:person_id' => 'people#continue_new', :as => 'continue_new_person'
  post 'people/continue_create' => 'people#continue_create', :as => 'continue_create_person'
  get 'people/edit/:id' => 'people#edit', :as => 'edit_person'
  post 'people/update' => 'people#update', :as => 'update_person'
  get 'people/destroy/:id' => 'people#destroy', :as => 'destroy_person'

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
