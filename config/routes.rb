Hoap::Application.routes.draw do
  get "admin/index", :as => :admin
  match "admin(/index)" => 'admin#index'

  get "admin/participant"
  post "admin/participant"

  get "admin/export"
  get "admin/reports", :as => :all_reports

  get "survey/index"

  post "survey/start"

  match "s/:code" => 'survey#start', :as => :start_link

  match "survey/page/:key" => 'survey#page', :as => :page

  match "survey/save/:page/:key" => 'survey#save', :as => :save, :via => :post

  resource :user_session

  get "users/index"

  resources :users

  match "report/:key" => 'report#index', :as => :report

  match "facts/:key" => 'report#facts', :as => :facts

  match "tips/:key" => 'report#tips', :as => :tips

  match "support/:key" => 'report#support', :as => :support

  match "referral/:key" => 'report#referral', :as => :referral

  match "finish/:key" => 'report#finish', :as => :finish

  match "report/save/:key" => 'report#save', :as => :report_save

  match "time/:page/:key" => 'report#time', :as => :time

  match "report/dpo_graph/:key" => 'report#dpo_graph', :as => :dpo_graph

  match "report/dpw_graph/:key" => 'report#dpw_graph', :as => :dpw_graph

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
  root :to => 'survey#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
