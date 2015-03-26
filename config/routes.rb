Rails.application.routes.draw do
  mount Depp::Engine, at: '/'

  resources :sessions do
    collection do
      post 'pki'
    end
  end

  get '/login', to: 'sessions#login', as: 'login'
  get '/logout', to: 'sessions#destroy'
end
