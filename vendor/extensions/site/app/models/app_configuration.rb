class AppConfiguration < Configuration

  MAIL_AUTH = ['none', 'plain', 'login', 'cram_md5']
  SECURE_CONNECTION_TYPES = ['None','SSL','TLS']


  preference :stylesheets, :string, :default => 'compiled/screen,compiled/cucharillas,dropdown'
  preference :site_name, :string, :default => 'Tienda Cucharillas Edu'
  preference :site_url, :string, :default => 'tiendacucharillasedu.com'
  preference :mails_from, :string
  preference :mail_bcc, :string
  preference :order_from, :string, :default => "soporte@tiendacucharillasedu.com"
  preference :order_bcc, :string
  preference :default_locale, :string, :default => 'es'
  preference :allow_locale_switching, :boolean, :default => false
  preference :default_country_id, :integer, :default => 188
  preference :show_zero_stock_products, :boolean, :default => true
  preference :orders_per_page, :integer, :default => 15   
  preference :admin_products_per_page, :integer, :default => 12 
  preference :products_per_page, :integer, :default => 15
  preference :default_tax_category, :string, :default => nil # Use the name (exact case) of the tax category if you wish to specify
  preference :logo, :string, :default => '/images/logo1.png'
  preference :admin_interface_logo, :string, :default => "/images/logo.png"
  preference :allow_ssl_in_production, :boolean, :default => false
  preference :allow_ssl_in_development_and_test, :boolean, :default => false
  preference :google_analytics_id, :string, :default => 'UA-11189532-1' # Replace with real Google Analytics Id 
  preference :allow_guest_checkout, :boolean, :default => true 
  preference :alternative_billing_phone,  :boolean, :default => false # Request extra phone for bill addr
  preference :alternative_shipping_phone, :boolean, :default => false # Request extra phone for ship addr
  preference :shipping_instructions,      :boolean, :default => false # Request instructions/info for shipping 
  preference :show_price_inc_vat, :boolean, :default => false 
  preference :auto_capture, :boolean, :default => false # automatically capture the creditcard (as opposed to just authorize and capture later)
  preference :address_requires_state, :boolean, :default => true # should state/state_name be required
  preference :use_mail_queue, :boolean, :default => false #send mail immediately or use a mail queue. 
  preference :enable_mail_delivery, :boolean, :default => false
  preference :mail_host, :string, :default => 'localhost'
  preference :mail_domain, :string, :default => 'localhost'
  preference :mail_port, :integer, :default => 25
  preference :mail_auth_type, :string, :default => MAIL_AUTH[0] 
  preference :smtp_username, :string
  preference :smtp_password, :string
  preference :secure_connection_type, :string, :default => SECURE_CONNECTION_TYPES[0] 
  preference :store_cc, :boolean, :default => false
  preference :store_cvv, :boolean, :default => false
  preference :allow_backorders, :boolean, :default => true
  preference :allow_backorder_shipping, :boolean, :default => false # should only be true if you don't need to track inventory
  preference :show_descendents, :boolean, :default => true
  preference :show_zero_stock_products, :boolean, :default => true
  validates_presence_of :name
  validates_uniqueness_of :name
  
end
