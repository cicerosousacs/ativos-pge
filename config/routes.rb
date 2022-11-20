Rails.application.routes.draw do
  namespace :ativo_pge do
    resources :admins
    resources :ativos do
      collection do
        match :link_to_deposit, via: %i[get post]
        get :link_to_deposit
        match :gerar_pdf_ativo, via: %i[get post]
        get 'gerar_pdf_ativo'
        post 'gerar_pdf_ativo'
      end
    end
    resources :users
    resources :areas
    resources :subareas
    resources :acquisitions
    resources :deposits, only: %i[index edit update]
    resources :bonds do
      collection do
        match :term_responsibility_asset, via: %i[get post]
        get 'term_responsibility_asset'
        post 'term_responsibility_asset'
      end
    end
    get '/bonds/history/:id', to: 'bonds#history'
  end

  namespace :ativo_pge do
    get 'welcome/index'
  end

  devise_for :admins

  root to: 'ativo_pge/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
