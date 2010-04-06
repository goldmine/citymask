ActionController::Routing::Routes.draw do |map|
  map.resources :tags
  map.resources :blogs
  map.resources :pages 
  map.resources :users, :member => { :enable => :put } do |u|
    u.resources :roles
    u.resources :tags, :controller => 'user_tags'
    u.resources :entries do |e|
      e.resources :comments
    end
    u.resources :albums do |a|
      a.resources :photos, :member => { :add_tag => :put, :remove_tag => :delete }
    end
  end
  
  map.resources :forums do |f|
    f.resources :topics do |t|
      t.resources :posts
    end
  end
  
  map.photos '/photos', :controller => 'photos', :action => 'recent_photos' 
  map.show_user 'user/:username', :controller => 'users', :action => 'show_by_name'
  map.login '/login', :controller => 'account', :action => 'login'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.index '/', :controller => 'pages', :action => 'index'
 
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
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
