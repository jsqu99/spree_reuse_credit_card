module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    orders = Spree::Order.where(:user_id => user.id).complete.order(:created_at).joins(:payments).where('spree_payments.source_type' => 'Spree::Creditcard').where('spree_payments.state' => 'completed')
    payments = orders.map(&:payments).flatten

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
