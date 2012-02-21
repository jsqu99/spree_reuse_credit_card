module Spree
  Creditcard.class_eval do
    def deleted?
      !!deleted_at
    end
  end
end
