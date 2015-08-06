Rails.application.routes.draw do
  # mount Depp::Engine, at: '/'
  scope module: 'depp' do
    resources :domains do
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

    resources :contacts do
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

    resource :poll do
      collection do
        post 'confirm_keyrelay'
        post 'confirm_transfer'
      end
    end

    resource :keyrelay

    resource :xml_console do
      collection do
        get 'load_xml'
      end
    end

    root 'polls#show'
  end

  resources :sessions do
    collection do
      post 'pki'
    end
  end

  get '/login', to: 'sessions#login', as: 'login'
  get '/logout', to: 'sessions#destroy'
end
