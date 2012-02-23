require 'spec_helper'

describe "PayWithCreditCards" do
  describe "GET /checkout/payment" do

    let (:user) { Factory(:user) }
    

    before(:each) do
      Factory(:bogus_payment_method, :display_on => :front_end)
      Factory(:shipping_method)

      sign_in_as!(user)
      @order = Factory(:order_in_delivery_state, :user => user)
      @order.next
      session[:order_id] = @order
    end

    context "no existing cards" do
      it "does not show an existing credit card list"do
        Spree::Creditcard.all.map(&:destroy)
        visit '/checkout/payment' 
        page.should_not have_css('table.existing-credit-card-list tbody tr')
      end
    end

    context "existing cards" do
      before(:each) do

        # set up existing payments with this credit card
        @credit_card = Factory(:creditcard)

        order = Factory(:order_in_delivery_state, :user => user)
        order.update!  # set order.total

        # go to payment state
        order.next
        order.state.should eq('payment')

        # add a payment 
        payment = Factory(:payment, :order => order, :source => @creditcard)

        # go to confirm
        order.next
        order.state.should eq('confirm')
      end

      it "show an existing credit card list" do
        visit '/checkout/payment'
        # page.should have_css('table.existing-credit-card-list tbody tr')
        save_and_open_page
        page.should have_xpath("//table[@class='existing-credit-card-list']/tbody/tr", :text => @credit_card.last_digits) #, :count => x) 
      end
    end
  end
end
