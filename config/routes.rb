Rails.application.routes.draw do
  resources :bookmarks, only: %i(edit destroy create index)
  resources :users, only: :show
  get 'tos', to: 'static_pages#tos'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'welcome', to: 'bookmarks#welcome'
  get 'friends', to: 'users#friends'

  root 'bookmarks#index'
end
