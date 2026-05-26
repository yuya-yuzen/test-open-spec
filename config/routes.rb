Rails.application.routes.draw do
  resources :todos, only: [ :index, :create, :edit, :update, :destroy ]
  root "todos#index"
end
