ActionController::Routing::Routes.draw do |map|
  
  map.resources :comparisons, :has_many => :results

  map.root :controller => "comparisons"

end
