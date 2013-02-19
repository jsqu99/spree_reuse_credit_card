module Spree
  class CreditCardsController < Spree::BaseController
    ssl_allowed
    respond_to :js

    def destroy
      @credit_card = Spree::CreditCard.find(params["id"])
      authorize! :destroy, @credit_card

      # TODO: think about the necessity of deleting payment profiles here.
      # I'm thinking we want to always leave them alone

      @credit_card.deleted_at = Time.now
      if @credit_card.save
        respond_with @credit_card
      else
        render template: 'spree/credit_cards/destroy_error'
      end

    end
  end
end
