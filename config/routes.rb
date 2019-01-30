Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'thoughts#index'
  get 'thoughts' => 'thoughts#index', :as => :home
  get 'thought' => 'thoughts#show'
  get 'thought/new' => 'thoughts#new'
  post 'thought/create' => 'thought#create'
end
