Rails.application.routes.draw do
  devise_for :users, path: "api/v1/users", controllers: {
    sessions: "api/v1/sessions",
    registrations: "api/v1/registrations"
  }
  resources :books
end
