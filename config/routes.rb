FeedFiction::Application.routes.draw do
  
  get "oldie/show"

  resources :invitations

  resources :accounts

  resources :flags

  get "notifications/show"

  get "notifications/index"

  get "notification/show"

  get "notification/index"


  resources :image_types
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end

  resources :contacts , only: [:create, :new]

  get "users/show"

  resources :comments

  get "like/create"

  get "like/destroy"
  get "sessions/connect_instagram"
  resources :story_lines
  resources :stories
  resources :categories
  resources :likes, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]

  resources :images do
    collection do
      get :facebook, :instagram, :upload
    end
  end

  namespace :admin do
    root to: "admin#index"
    resources :users
    resources :stories
    resources :fakers
    resources :story_lines
    resources :statuses
  end
    
 

  
  
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/privacy', to: 'static_pages#privacy'  
  match '/terms', to: 'static_pages#terms'
  match '/contact' => 'contacts#new', :as => 'contacts', :via => :get
  match '/contact' => 'contacts#create', :as => 'contacts', :via => :post

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'oauth/instagram/callback', to: 'sessions#callback_instagram'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  match '/facebook', to: 'images#facebook' 
  match '/instagram', to: 'images#instagram' 
  match 'register/start-story', to: 'register#start', as: 'start_story_wizard'
  match 'register/follow-friends', to: 'register#friends' , as: 'find_friends_wizard'
  match 'register/facebook', to: 'register#facebook' , as: 'import_facebook_wizard'
  match 'register/instagram', to: 'register#instagram' , as: 'import_instagram_wizard'
  match '/all', to: 'feeds#general_feed' , as: 'general_feed'
  match "/testform" , to: 'stories#testform'
  match '/old' , to: 'oldie#show'
  match '/fb_channel', to: 'misc#fb_channel'


  root to: 'feeds#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
