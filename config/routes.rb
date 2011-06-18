Whoisjuliosantos::Application.routes.draw do
  scope "/", :controller => :julio do
    get "/index", :to => :index, :as => "home"
    get "/cv", :to => :cv, :as => "cv"
    get "/contact", :to => :contact, :as => "contact"
  end

  root :to => "julio#index"
end
