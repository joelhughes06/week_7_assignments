PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  # get '/posts', to: 'posts#index'
  # get '/posts/:id', to: 'posts#show'
  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # get '/posts/:id/edit', to: 'posts#edit'
  # patch '/posts/:id', to: 'posts#update'


  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'


  resources :posts, except: [:destroy] do #added this line per the assignment instructions
  	resources :comments, only: [:create, :show, :edit, :update]
    member do
      post 'vote'
    end
  end

  resources :categories, only: [:create, :new, :show]
  resources :users, only: [:create]


end
