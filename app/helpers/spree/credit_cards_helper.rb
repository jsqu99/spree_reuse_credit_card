module Spree
  module CreditCardsHelper
    def link_to_delete_credit_card(card)
      #            <%# passing in an explicit 'url' here let's us make use of this 'admin' helper and bypass the object_url %>
      #            <%# (from resourcec_ontroller) that is embedded in the helper %>

      s = link_to_delete card, {
                :url => spree.credit_card_url(card),
                :dataType => 'json',
                :success => "function(r){ jQuery('##{spree_dom_id card}').fadeOut('hide'); displayCreditCardDeleteStatus('#{t(:credit_card_successfully_removed)}'); }",
                :error => "function(r){ displayCreditCardDeleteStatus('#{t(:credit_card_not_removed)}'); }"}
      s.html_safe
    end
  end
end
