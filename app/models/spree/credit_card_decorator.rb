module Spree
  CreditCard.class_eval do
    Spree::PermittedAttributes.source_attributes << :deleted_at

    def deleted?
      !!deleted_at
    end
  end
end
