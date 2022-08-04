Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'shortener', to: 'shortened_urls#new', as: :new_shortener
    end
  end
  get '/:id' => "shortened_urls#show"
end
