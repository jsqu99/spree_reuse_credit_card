class CreditCardAbility

  include CanCan::Ability

  def initialize(user)
    can :manage, Spree::Creditcard do |cc|
      # we use payment state below b/c we could have a cancelled order w/ a payment that 
      # was made successfully.  This sql needs to closely mirror the one we use when 
      # presenting the available cards to the user
      # NOTE the difference between order.state == 'complete' and payment.state == 'completed' (d on the end)
      cc.payments.joins(:order).where("spree_orders.user_id" => user.id).where('spree_payments.state' => 'completed').exists?  
    end
  end
end

