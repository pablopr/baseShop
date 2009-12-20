# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PaypalExpressExtension < Spree::Extension
  version "1.0"
  description "A Spree Extension that adds PPX as a secondary payment gateway."
  url "http://github.com/bryanmtl/paypal_express"

  # Please use paypal_express/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
   
    AppConfiguration.class_eval do
        preference :use_paypal_express, :boolean, :default => true
    end
      
   Admin::ConfigurationsController.class_eval do
     
     before_filter :add_ppx_links, :only => :index

     def add_ppx_links
       @extension_links << {:link => admin_paypal_express_settings_path, :link_text => t('Paypal Express Settings'), :description => "Setup your paypal express settings"}
     end

   end
   
   Admin::CreditcardPaymentsController.class_eval do
     before_filter :load_data, :except => :edit
     before_filter :load_amount, :except => [:country_changed, :edit]
     def edit
       @creditcard_payment = Payment.find(params[:id])
       @order = Order.find_by_number(params[:order_id])
       @selected_country_id = params[:payment_presenter][:address_country_id].to_i if params.has_key?('payment_presenter')
       @selected_country_id ||= @order.bill_address.country_id if @order and @order.bill_address
       @selected_country_id ||= Spree::Config[:default_country_id]
       @amount = params[:amount] || @order.total
       @states = State.find_all_by_country_id(@selected_country_id, :order => 'name')  
       @countries = Country.find(:all)
       
     end
     
   end
   

    OrdersController.class_eval do
      # include this to enable paypal express checkout functions
      include PaypalExpress  
    end
    
    Order.class_eval do
      has_many :paypal_payments
            
      def complete_paypal_order
        self.update_attribute(:state, 'paid')
      end
    
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
