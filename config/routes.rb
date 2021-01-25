Rails.application.routes.draw do


  get 'account_activations/edit'

  get 'sessions/new'

  root              'static_pages#home'
  get 'about'     =>'static_pages#about'
  get 'help'      => 'static_pages#help'
  get 'poop'      => 'static_pages#poop'
  get 'signup'    => 'users#new'
  get 'login'     =>  'sessions#new'
  post 'login'    =>  'sessions#create'
  delete 'logout' =>  'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
