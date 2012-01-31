class CreditcardsController < Spree::BaseController

  respond_to :js

  def destroy
    @creditcard = Creditcard.find(params["id"])

    # TODO: think about the necessity of deleting payment profiles here.
    # I'm thinking we want to always leave them alone

    if @creditcard.update_attribute(:deleted_at, Time.now)
      flash[:notice] = I18n.t(:creditcard_successfully_removed)
      respond_with(@creditcard) do |format|
        format.js   { render :partial => "/shared/card_destroy" }
      end
    end

  end
end
