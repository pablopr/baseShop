# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resource :paypal_express_settings
end

map.resources :orders, :member => { :shipping_method => :any, :payment => :any, :confirmation => :any,
                                    :express_checkout => :any, :confirm => :any, :complete => :any }