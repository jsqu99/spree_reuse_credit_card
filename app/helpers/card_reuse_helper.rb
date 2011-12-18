module CardReuseHelper
  def all_credit_cards_for_user(user)
    return nil unless user

    # assumption is that all payments to mcsweeney's are via credit card
    orders = Order.where(:user_id => user.id).complete.order(:created_at)
    payments = orders.map(&:payments).flatten

    payments.reject! {|payment| payment.state != 'completed'}

    payments.map(&:source)
  end
end
