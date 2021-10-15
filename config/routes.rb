Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post :authenticate, to: 'authentication#authenticate'
  resource :team, only: %i[show update]
  resources :players, except: %i[edit new], param: :uuid
  resources :matches, except: %i[edit new], param: :uuid
end
