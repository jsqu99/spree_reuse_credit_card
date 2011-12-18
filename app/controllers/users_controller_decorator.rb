UsersController.class_eval do
  require 'card_reuse'

  before_filter :load_existing_cards, :only => :show

  private

  def load_existing_cards
    @cards = all_credit_cards_for_user(@user)
  end
end
