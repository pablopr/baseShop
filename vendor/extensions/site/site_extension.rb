# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate 
    AppConfiguration.class_eval do 
      preference :stylesheets, :string, :default => 'compiled/screen,queso,dropdown'
      preference :site_name, :string, :default => 'Tapershop demo site'
      preference :site_url, :string, :default => 'demo.tapershop.com'
      preference :default_title, :string, :default => 'Hacemos tiendas online y funcionan'
      preference :mails_from, :string
      preference :mail_bcc, :string
      preference :order_from, :string, :default => "orders@tapershop.com"
      preference :order_bcc, :string
      preference :default_locale, :string, :default => 'es'
      preference :allow_locale_switching, :boolean, :default => false
      preference :default_country_id, :integer, :default => 188
      preference :show_zero_stock_products, :boolean, :default => true
      preference :orders_per_page, :integer, :default => 15   
      preference :admin_products_per_page, :integer, :default => 12 
      preference :products_per_page, :integer, :default => 15
      preference :default_tax_category, :string, :default => nil # Use the name (exact case) of the tax category if you wish to specify
      preference :logo, :string, :default => '/images/logo.png'
      preference :admin_interface_logo, :string, :default => "/images/logo.png"
      preference :allow_ssl_in_production, :boolean, :default => false
      preference :allow_ssl_in_development_and_test, :boolean, :default => false
      preference :google_analytics_id, :string, :default => '' # Replace with real Google Analytics Id 
      preference :allow_guest_checkout, :boolean, :default => true 
      preference :alternative_billing_phone,  :boolean, :default => false # Request extra phone for bill addr
      preference :alternative_shipping_phone, :boolean, :default => false # Request extra phone for ship addr
      preference :shipping_instructions,      :boolean, :default => false # Request instructions/info for shipping 
      preference :show_price_inc_vat, :boolean, :default => false 
      preference :auto_capture, :boolean, :default => false # automatically capture the creditcard (as opposed to just authorize and capture later)
      preference :address_requires_state, :boolean, :default => true # should state/state_name be required
      preference :use_mail_queue, :boolean, :default => false #send mail immediately or use a mail queue. 
    end
    
    	#register all payment gateways
  		[
  			Gateway::Transferencia
     ].each{|gw|
       begin
         gw.register  
       rescue Exception => e
         $stderr.puts "Error registering gateway #{c_model}"
       end
     }
  end
  
end