class CreditCardAbility

  include CanCan::Ability

  def initialize(user)
    can :manage, Creditcard do |cc|
      cc.payments.joins(:order).
        where("orders.user_id" => user.id).
        where("orders.state" => "complete").exists?
    end
  end
end

