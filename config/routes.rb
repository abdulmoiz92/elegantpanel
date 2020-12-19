Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders
  get "searchorder", to: "orders#search" 
  get "orderpdf" => 'orders#orderpdf', as: :orders_pdf_path, format: true, defaults: { format: 'pdf' }
  get "searchpdf", to: "orders#searchpdf"

  root "dashboard#home"
  get "searchstats", to: "dashboard#search"
end
