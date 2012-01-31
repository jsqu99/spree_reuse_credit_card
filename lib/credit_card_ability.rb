class CreditCardAbility

  include CanCan::Ability

  def initialize(user)
#    binding.pry
    can :manage, Creditcard do |cc|
      cc.user == user
    end
  end
end

