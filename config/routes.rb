Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'dashboard', to: 'dashboard#index'

  get 'letters/combinations', to: 'letters#combinations'
  resources :letters, only: [:index]
  resources :words, only: [:index]
  resources :grammar_lessons, only: [:index, :show] do
    member { post :complete }
  end
  resources :reading_passages, only: [:index, :show]
  resources :nigandu, only: [:index, :show, :update]

  get  'quizzes',        to: 'quizzes#index',  as: :quizzes
  post 'quizzes/submit', to: 'quizzes#submit', as: :submit_quizzes

  post 'user_letters', to: 'user_letters#create'
  post 'user_words',   to: 'user_words#create'

  get 'audio/tts', to: 'audio#tts'

  get "up" => "rails/health#show", as: :rails_health_check
end
