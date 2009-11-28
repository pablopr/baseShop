class Gateway::Transferencia < Gateway
  attr_accessor :test
  
  def provider_class
    self.class
  end

	def preferences
		{}
	end
  
  def authorize(money, creditcard, options = {})      
      ActiveMerchant::Billing::Response.new(true, "Bogus Gateway: Forced success", {}, :test => true, :authorization => '12345')
  end

  def purchase(money, creditcard, options = {})
      ActiveMerchant::Billing::Response.new(true, "Bogus Gateway: Forced success", {}, :test => true, :authorization => '12345')
  end 

  def credit(money, ident, options = {})
      ActiveMerchant::Billing::Response.new(true, "Bogus Gateway: Forced success", {}, :test => true, :authorization => '12345')
  end

  def capture(money, ident, options = {})
      ActiveMerchant::Billing::Response.new(true, "Bogus Gateway: Forced success", {}, :test => true, :authorization => '12345')
  end
  
  def void(ident, options = {})
      ActiveMerchant::Billing::Response.new(true, "Bogus Gateway: Forced success", {}, :test => true, :authorization => '12345')
  end
  
  def test?
    # Test mode is not really relevant with bogus gateway (no such thing as live server)
    true
  end

end