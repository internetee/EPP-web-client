Rails.application.routes.draw do
  # mount Depp::Engine, at: '/'

  resources :domains, controller: 'depp/domains' do
    collection do
      post 'update', as: 'update'
      post 'destroy', as: 'destroy'
      get 'renew'
      match 'transfer', via: [:post, :get]
      get 'edit'
      get 'info'
      get 'check'
      get 'delete'
    end
  end

  resources :contacts, controller: 'depp/contacts' do
    member do
      get 'delete'
      post 'fullshow' # a bit more secure than get for password field
      post 'fulledit' # a bit more secure than get for password field
    end

    collection do
      get 'check'
      get 'info'
    end
  end

  resource :poll, controller: 'depp/polls' do
    collection do
      post 'confirm_keyrelay'
      post 'confirm_transfer'
    end
  end

  resource :keyrelay, controller: 'depp/keyrelays'

  resource :xml_console, controller: 'depp/xml_consoles' do
    collection do
      get 'load_xml'
    end
  end

  root 'depp/polls#show'

  resources :sessions do
    collection do
      post 'pki'
    end
  end

  get '/login', to: 'sessions#login', as: 'login'
  get '/logout', to: 'sessions#destroy'
end
