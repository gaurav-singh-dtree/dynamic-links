DynamicLinks::Engine.routes.draw do
  get "/links" => "dynamic_links#index"
  put "/links/update_status" => "dynamic_links#update_status"
end