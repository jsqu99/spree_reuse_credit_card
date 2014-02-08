module Spree
  Payment.class_eval do
    Spree::PermittedAttributes.payment_attributes << :source
    Spree::PermittedAttributes.payment_attributes << :source_attributes
  end
end
