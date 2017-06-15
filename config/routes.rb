Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  

  get '/admin' => 'admin#show'

  get '/admin/configure' => 'admin#new'
  post '/admin/configure' => 'admin#create'

  get 'admin/login' => 'admin#login'
  post 'admin/login' => 'admin#authenticate'
end
