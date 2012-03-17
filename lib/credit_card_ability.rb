class CreditCardAbility

  include CanCan::Ability

  def initialize(user)
    can :manage, Spree::Creditcard do |cc|
      cc.payments.joins(:order).
        where("spree_orders.user_id" => user.id).
        where("spree_orders.state" => "complete").exists?
    end
  end
end

