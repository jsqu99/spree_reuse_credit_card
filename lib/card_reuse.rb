module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    payments = credit_card_payments_for_user(user)

    payments.map do |payment| 
      src = payment.source

      if valid_for_reuse?(src)
        src
      else
        nil
      end
    end.compact.uniq
  end

  def card_expired?(payment_source)
    exp = DateTime.new(payment_source.year.to_i, payment_source.month.to_i).end_of_month
    now = DateTime.now.end_of_month

    exp < now
  end

  def valid_for_reuse?(payment_source)
    # some payment gateways use only one of these?  stripe possibly?
    !(payment_source.nil? || (payment_source.gateway_payment_profile_id.nil? && payment_source.gateway_customer_profile_id.nil?) || payment_source.deleted? || card_expired?(payment_source))
  end

  def credit_card_payments_for_user(user)
    Spree::Payment.joins(:order).where('spree_orders.completed_at IS NOT NULL').where('spree_orders.user_id' => user.id).order('spree_orders.created_at').where('spree_payments.source_type' => 'Spree::CreditCard').where('spree_payments.state' => 'completed')
  end
end
