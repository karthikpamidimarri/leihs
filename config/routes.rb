ActionController::Routing::Routes.draw do |map|

  
  map.resources :users, :collection => { :visits => :get,
                                         :timeline => :get,
                                         :timeline_visits => :get,
                                         :account => :get }
  map.resource :session
  
  # For RESTful_Authentication
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  # For RESTful_ACL
  #map.error '/error', :controller => 'sessions', :action => 'error'
  #map.denied '/denied', :controller => 'sessions', :action => 'denied'

  map.backend '/backend', :controller => 'backend/dashboard'
  map.admin '/admin', :controller => 'admin/inventory_pools'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  map.namespace :backend do |backend|
    # TODO 28** nesting to inventory_pool, removing session
#    backend.resources :acknowledge
#    backend.resources :dashboard
    backend.resources :orders
    backend.resources :contracts
    backend.resources :locations
    backend.resources :items, :member => { :model => :get,
                                           :location => :get,
                                           :status => :get }
    backend.resources :models, :collection => { :auto_complete => :get },
                               :member => { :properties => :get,
                                            :accessories => :get,
                                            :images => :get } do |model|
      model.resources :items
# TODO 28** working here
#      model.resources :categories
#      model.resources :compatibles, :controller => :models
    end
  end

  map.namespace :admin do |admin|
    admin.resources :inventory_pools, :member => { :locations => :get,
                                                   :managers => :get,
                                                   :add_manager => :put } do |inventory_pool|
      inventory_pool.resources :items
    end
    admin.resources :items, :member => { :model => :get,
                                         :inventory_pool => :get }
    admin.resources :models, :collection => { :auto_complete => :get },
                             :member => { :properties => :get,
                                          :accessories => :get,
                                          :images => :get } do |model|
      model.resources :items
      model.resources :categories
      model.resources :compatibles, :controller => :models
    end
    admin.resources :categories do |category|
      category.resources :models
    end
    admin.resources :users, :collection => { :auto_complete => :get }
    admin.resources :roles
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect 'authenticator/zhdk/:action/:id', :controller => 'authenticator/zhdk'
  map.connect ':controller/:action/:id', :defaults => { :controller => 'frontend' }
  map.connect ':controller/:action/:id.:format'
end
