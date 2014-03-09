App99cats::Application.routes.draw do
  root :to =>'cats#index'
  resources :cats do
    resources :cat_rental_requests, :only => :show
  end
  resources :cat_rental_requests do
    patch 'approve', :on => :member
    patch 'deny', :on => :member
  end
end
