module CheckoutsHelper
  def checkout_steps                                                      
    checkout_steps = %w{registration billing shipping shipping_method payment}
    checkout_steps.delete "registration" if current_user
    checkout_steps
  end
end