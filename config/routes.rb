# -*- encoding : utf-8 -*-
Kecheng::Application.routes.draw do


  get "home/index"
  match "home/open_courses"
  match "select_grades" => 'grades_courses#select_grades'
  match "exercises/update_text" => "exercises#update_text", :as => "update_text"

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :exercise_texts
  resources :qtypes
  resources :book_categories
  resources :books
  resources :exercises
  resources :messages

  resources :courses
  resources :student_homeworks

  resources :grades_courses do
    collection do
      match 'select'
    end
    resources :lessons do
      resources :homeworks
    end
  end

  resources :homeworks do
    member do
      match :check
    end
  end
  resources :users do
    collection do
      post :create_user_from_admin
    end
  end

  post 'users/:id' => 'users#update'


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

  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
