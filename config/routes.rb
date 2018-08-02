Rails.application.routes.draw do

  get 'questions' => 'questions#index'
  post 'questions' => 'questions#practice'
  get 'questions/:id/show' => 'questions#show'
  post 'questions/:id/star_toggle' => 'questions#star_toggle'
  get 'questions/:id/edit' => 'questions#edit'
  post 'questions/:id/edit' => 'questions#update'
  get 'questions/next' => 'questions#next_question'
  get 'questions/new' => 'questions#new'
  post 'questions/new' => 'questions#create'

  get 'books' => 'books#index'
  get 'books/manage' => 'books#manage'
  get 'books/show/:id' => 'books#show'
  get 'books/new' => 'books#new'
  post 'books/new' => 'books#create'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  post 'users/:user_id/answers/:question_id' => 'answer_events#create'

  get 'account/edit' => 'users#edit'
  post 'account/edit'=> 'users#update'

  root :to => 'welcome#index'

  get 'user_home' => 'user_home#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
