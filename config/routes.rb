Rails.application.routes.draw do
  namespace :ativo_pge do
    resources :admins
    resources :ativos do
      collection do
        match :vincular_deposito, via: %i[get post]
        get :vincular_deposito
      end
    end
    resources :users
    resources :areas
    resources :subareas
    resources :acquisitions
    resources :bonds
  end

  namespace :ativo_pge do
    get 'welcome/index'
  end
  
  devise_for :admins

  root to: 'ativo_pge/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
