LittlePrinter::Application.routes.draw do

  # Angular
  get '/', to: redirect('/')

  namespace 'api' do
    resources :messages, only: [:index, :new, :create]
  end

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

  get '/yo' => 'home#yo'
  get '/yo_test' => 'home#yo_layout'

end
