module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    payments = Spree::Payment.joins(:order).where('spree_orders.completed_at IS NOT NULL').where('spree_orders.user_id' => user.id).order('spree_orders.created_at').where('spree_payments.source_type' => 'Spree::Creditcard').where('spree_payments.state' => 'completed')

    payments.map do |payment| 
      src = payment.source

      # some payment gateways use only one of these?  stripe possibly?
      if (src.gateway_payment_profile_id.nil? && src.gateway_customer_profile_id.nil?) || src.deleted?
        nil
      else
        src
      end
    end.compact.uniq
  end
end
