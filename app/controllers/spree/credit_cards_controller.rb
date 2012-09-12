module Spree
  class CreditCardsController < Spree::BaseController

    respond_to :json

    def destroy
      @credit_card = Spree::CreditCard.find(params["id"])
      authorize! :destroy, @credit_card

      # TODO: think about the necessity of deleting payment profiles here.
      # I'm thinking we want to always leave them alone

      if @credit_card.update_attribute(:deleted_at, Time.now)
        respond_with(@credit_card) do |format|
          format.json { render :json => {} }
        end
      else

        respond_with(@credit_card) do |format|
          format.json { render :status => 500 }
        end
      end
    end
  end
end
