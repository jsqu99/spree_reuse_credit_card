Spree::Api::CheckoutsController.class_eval do      
  private

    def object_params
      # For payment step, filter order parameters to produce the expected nested attributes for a single payment and its source, discarding attributes for payment methods other than the one selected
      # respond_to check is necessary due to issue described in #2910

      if @order.has_checkout_step?("payment") && @order.payment?
        if params[:existing_card]
          credit_card = Spree::CreditCard.find(params[:existing_card])
          authorize! :manage, credit_card
          params[:order][:payments_attributes].first[:source] = credit_card
        elsif params[:payment_source].present? && source_params = params.delete(:payment_source)[params[:order][:payments_attributes].first[:payment_method_id].underscore]
          params[:order][:payments_attributes].first[:source_attributes] = source_params
        end
        if params[:order].present? && params[:order][:payments_attributes]
          params[:order][:payments_attributes].first[:amount] = @order.total
        end
      end
      params[:order] || {}
    end
end
