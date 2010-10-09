ActionController::Routing::Routes.draw do |map|
  map.connect 'orders/my', :controller => 'orders', :action => 'my'
  map.connect 'settings/lock_system', :controller => 'settings', :action => 'lock_system'
  map.connect 'settings/unlock_system', :controller => 'settings', :action => 'unlock_system'

  map.connect 'vendors/:id/notify_users',
              :controller => 'vendors',
              :action => 'notify_users',
              :id => /\d+/
  map.connect 'vendors/:id/mark_orders_complete',
              :controller => 'vendors',
              :action => 'mark_orders_complete',
              :id => /\d+/
  map.connect 'vendors/:id/mark_orders_new',
              :controller => 'vendors',
              :action => 'mark_orders_new',
              :id => /\d+/

  map.resource :account, :controller => "users"
  map.resource :user_session
  map.resources :users
  map.resources :lunches
  map.resources :orders
  map.resources :password_resets
  map.resource :settings
  map.resources :vendors

  map.root :controller => "user_sessions", :action => "new"
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
end
