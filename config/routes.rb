Rails.application.routes.draw do
  namespace :ativo_pge do
    resources :admins
    resources :ativos do
      collection do
        match :vincular_deposito, via: %i[get post]
        get :vincular_deposito
        match :gerar_pdf_ativo, via: %i[get post]
        get 'gerar_pdf_ativo'
        post 'gerar_pdf_ativo'
      end
    end
    resources :users
    resources :areas
    resources :subareas
    resources :acquisitions
    resources :bonds do
      collection do
        match :pdf_termo_responsabilidade_ativo, via: %i[get post]
        get 'pdf_termo_responsabilidade_ativo'
        post 'pdf_termo_responsabilidade_ativo'
      end
    end
  end

  namespace :ativo_pge do
    get 'welcome/index'
  end
  
  devise_for :admins

  root to: 'ativo_pge/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
