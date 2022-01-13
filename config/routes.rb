Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json} do
    resources :applications do
      resources :chats do
        resources :messages
      end
    end
  end

end