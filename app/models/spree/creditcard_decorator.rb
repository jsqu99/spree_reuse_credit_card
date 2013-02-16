module Spree
  Creditcard.class_eval do
    attr_accessible :deleted_at

    def deleted?
      !!deleted_at
    end
  end
end
