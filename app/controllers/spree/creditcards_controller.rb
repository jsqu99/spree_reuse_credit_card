module Spree
  class CreditcardsController < Spree::BaseController
    ssl_allowed
    respond_to :js

    def destroy
      @creditcard = Spree::Creditcard.find(params["id"])
      authorize! :destroy, @creditcard

      # TODO: think about the necessity of deleting payment profiles here.
      # I'm thinking we want to always leave them alone

      @creditcard.deleted_at = Time.now
      if @creditcard.save
        respond_with @creditcard
      else
        render template: 'spree/creditcards/destroy_error'
      end

    end
  end
end
