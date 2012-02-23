FactoryGirl.define do

  factory :order_in_address_state, :parent => :order do
    after_build { |order|
      order.line_items << Factory(:line_item, :order => order)
    }

    after_create { |order|
      order.next!
    }
  end

  factory :order_in_delivery_state, :parent => :order_in_address_state do
    after_create { |order| order.next! }
  end

  factory :order_in_payment_state, :parent => :order_in_delivery_state do
    after_create { |order| 
      order.next! 
    }
  end

  factory :order_in_confirm_state, :parent => :order_in_payment_state do
    after_create do |order|
      order.next!
    end
  end

  factory :order_in_complete_state, :parent => :order_in_confirm_state do
    after_create { |order| order.next! && order.finalize! }
  end



#  factory :order_in_payment_state, :parent => :order do
#    after_create { |order|
#      # order.line_items << Factory(:line_item, :order => order)
#
#      order.next!
#      order.next!
#      order.next!
#
#    }
#  end
end
