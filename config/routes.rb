Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'oauths/vkontakte'
  post 'toggle_group/:id'    => 'groups#toggle_group', as: :toggle_group
  post 'toggle_purchase/:id' => 'purchases#toggle_purchase', as: :toggle_purchase
  root 'pages#index'

  get 'tags/:tag', to: 'recipes#index', as: :tag

  get 'about'   => 'pages#about'
  get 'alltags' => 'pages#alltags'
  get 'addtolove' => 'recipes#addtolove'
  resource :profile, only: [:show, :edit, :update], as: :user_profile

  devise_for :users, :controllers => { :omniauth_callbacks => "oauths" }

  resources :users, :purchases, :comments
  resources :recipes do 
    resources :comments
  end  
  resources :groups do
    get :autocomplete_group_name, on: :collection
  end

end
