Rails.application.routes.draw do
  root "customers#new"
  resources :customers, only: [ :new, :create ]
  get "/manifest.json", to: proc { [ 200, { "Content-Type" => "application/json" }, [ File.read(Rails.root.join("public/manifest.json")) ] ] }
  get "thank_you", to: "customers#thank_you"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
