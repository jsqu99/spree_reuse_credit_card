module Spree
  Payment.class_eval do
    attr_accessible :source, :source_attributes
  end
end
