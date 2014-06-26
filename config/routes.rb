LittlePrinter::Application.routes.draw do

  scope '/backoffice' do
    devise_for :admins,
      path: '',
      path_names: { sign_in: "login", sign_out: "logout" },
      controllers: { sessions: "backoffice/sessions" }
  end
  namespace 'backoffice' do
    root to: 'home#dashboard'
    resources :admins
    resources :yos, only: [:index]
  end

  devise_for :admins, skip: :all
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get '/yo' => 'home#yo'
  get '/yo_test' => 'home#yo_layout'

end
