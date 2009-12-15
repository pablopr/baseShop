class AppConfiguration < Configuration

  MAIL_AUTH = ['none', 'plain', 'login', 'cram_md5']
  SECURE_CONNECTION_TYPES = ['None','SSL','TLS']
  preference :mail_auth_type, :string, :default => MAIL_AUTH[0] 
  preference :smtp_username, :string
  preference :smtp_password, :string
  preference :secure_connection_type, :string, :default => SECURE_CONNECTION_TYPES[0] 
  preference :mails_from, :string
  preference :mail_bcc, :string
  preference :order_bcc, :string
  preference :store_cc, :boolean, :default => false
  preference :store_cvv, :boolean, :default => false
  
   preference :stylesheets, :string, :default => 'compiled/screen,qpomo,dropdown'
   preference :site_name, :string, :default => 'QPomo.com'
   preference :site_url, :string, :default => 'qpomocom'
   preference :mails_from, :string
   preference :mail_bcc, :string
   preference :order_from, :string, :default => "orders@qpomo.com"
   preference :order_bcc, :string
   preference :default_locale, :string, :default => 'es'
   preference :allow_locale_switching, :boolean, :default => false
   preference :default_country_id, :integer, :default => 188
   preference :show_zero_stock_products, :boolean, :default => true  
   preference :admin_products_per_page, :integer, :default => 12 
   preference :products_per_page, :integer, :default => 12
   preference :default_tax_category, :string, :default => nil # Use the name (exact case) of the tax category if you wish to specify
   preference :logo, :string, :default => '/images/logo.png'
   preference :admin_interface_logo, :string, :default => "/images/logo.png"
   preference :allow_ssl_in_production, :boolean, :default => false
   preference :allow_ssl_in_development_and_test, :boolean, :default => false
   preference :google_analytics_id, :string, :default => 'UA-11188402-1' # Replace with real Google Analytics Id
   preference :alternative_billing_phone,  :boolean, :default => false # Request extra phone for bill addr
   preference :alternative_shipping_phone, :boolean, :default => false # Request extra phone for ship addr
   preference :shipping_instructions,      :boolean, :default => false # Request instructions/info for shipping 
   preference :show_price_inc_vat, :boolean, :default => false 
   preference :auto_capture, :boolean, :default => false # automatically capture the creditcard (as opposed to just authorize and capture later)
   preference :address_requires_state, :boolean, :default => true # should state/state_name be required
   preference :use_mail_queue, :boolean, :default => false #send mail immediately or use a mail queue. 


  validates_presence_of :name
  validates_uniqueness_of :name
  
end