Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :favourites
  resources :rates
  resources :appointments
  resources :tables
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'login',to:"main#login"
  post 'login',to:"main#login_post"

  get 'logout',to:"main#logout"

  get 'register',to:"main#register"
  post 'register',to:"main#register_create"

  get 'main',to:"main#main"

  get 'edit_profile',to:"main#edit_profile"
  patch 'edit_profile',to:"main#edit_profile_post"

  get 'favourite', to:"main#favourite"
  delete 'favourite_remove/:restaurant_id',to:'main#favourite_remove'

  

  get 'restaurant_list', to:'main#restaurant_list'

  get 'restaurant/:restaurant_id',to:"main#restaurant"

  post 'addToFavorite/:restaurant_id', to:"main#add_to_favorite"

  get 'appointment/:restaurant_id', to:"main#appointment"
  post 'appointment/:restaurant_id', to:"main#appointment_post"

  get 'rate/:restaurant_id', to:"main#rate"
  post 'rate', to:"main#rate_post"
  get 'edit_rate/:restaurant_id', to:"main#edit_rate"
  post 'edit_rate', to:"main#edit_rate_post"

  get 'comment/:restaurant_id', to:"main#comment"
  post 'comment', to:"main#comment_post"
  get 'edit_comment/:restaurant_id', to:"main#edit_comment"
  post 'edit_comment', to:"main#edit_comment_post"

  delete 'cancelAppointment/:appointment_id',to:"main#cancelAppointment"

  get 'appointment/:restaurant_id', to:'main#appointment'
  post 'appointment', to:"main#appointment_post"

  post 'like/:comment_id' , to:'main#like'

end
