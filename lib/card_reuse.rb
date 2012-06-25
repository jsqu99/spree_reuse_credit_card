module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    payments = Payment.joins(:order).where('orders.completed_at IS NOT NULL').where('orders.user_id' => user.id).order('orders.created_at').where('payments.source_type' => 'Creditcard').where('payments.state' => 'completed')


    payments.map do |payment| 
      src = payment.source

      if src.gateway_payment_profile_id.nil? || src.gateway_customer_profile_id.nil? || src.deleted?
        nil
      else
        src
      end
    end.compact.uniq
  end
end
