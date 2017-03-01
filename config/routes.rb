Rails.application.routes.draw do
  resources :posts
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#desroy', as: 'signout', via: [:get, :set]
end
