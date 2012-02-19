module CreditcardsHelper
  def link_to_delete_credit_card(card)
    #            <%# passing in an explicit 'url' here let's us make use of this 'admin' helper and bypass the object_url %>
    #            <%# (from resourcec_ontroller) that is embedded in the helper %>

    %(link_to_delete card, {
                :url => creditcard_url(card),
                :dataType => 'json',
                :success => "function(r){ jQuery('##{dom_id card}').fadeOut('hide'); displayCreditCardDeleteStatus(#{t(:creditcard_successfully_removed)}); }",
                :failure => "function(r){ displayCreditCardDeleteStatus(#{t(:creditcard_not_removed)}); }"} )
  end
end
