Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #===============================================
  #Home routes
  #===============================================
  root 'home#index'
  get '/standings' => 'home#standings'
  get '/docs' => 'home#docs'

  #===============================================
  #API routes
  #===============================================
  get '/api/stock' => 'api#stock_quote'
  get '/api/stock/list' => 'api#stock_list'
  get '/api/buy' => 'api#buy'
  get '/api/sell' => 'api#sell'
  get '/api/account' => 'api#account'

  #===============================================
  #Broker routes
  #===============================================
  get '/broker' => 'broker#show'

  get '/broker/register' => 'broker#new'
  post '/broker/register' => 'broker#create'

  get '/broker/login' => 'broker#login'
  post '/broker/login' => 'broker#authenticate'

  #===============================================
  #Admin routes
  #===============================================
  get '/admin' => 'admin#show'

  get '/admin/configure' => 'admin#new'
  post '/admin/configure' => 'admin#create'

  get 'admin/login' => 'admin#login_form'
  post 'admin/authenticate' => 'admin#authenticate'

  #===============================================
  #Stock routes
  #===============================================
  #post '/stock/new' => 'stock#create'
  #post '/stock/update' => 'stock#update'
  #post '/stock/delete' => 'stock#destroy'

  # get '/stock/:ticker' => 'stock#show'

  # get '/stock/api/:ticker' => 'stock#query_single'

  #===============================================
  #SideKiq routes
  #===============================================
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  post '/api/linux_workshop' => 'api#uotta_hack'
end
