require 'spec_helper'

describe "PayWithCreditCards" do
  describe "GET /checkout/payment" do

    let (:user) { Factory(:user) }
    
    before(:each) do
      @bogus_payment_method = Factory(:bogus_payment_method, :display_on => :front_end)

      shipping_method = Factory(:shipping_method)
      Spree::ShippingMethod.stub(:all_available) { [shipping_method] }

      sign_in_as!(user)
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
        @credit_card = Factory(:credit_card)

        order = Factory(:order_in_delivery_state, :user => user)
        order.update!  # set order.total

        # go to payment state
        order.next
        order.state.should eq('payment')

        # add a payment 
        payment = Factory(:payment, :order => order, :source =>  @credit_card, :amount => order.total, :payment_method => @bogus_payment_method)

        # go to confirm
        order.next
        order.state.should eq('confirm')

        # go to complete
        order.next
        order.state.should eq('complete')
      end

      it "allows an existing credit card to be chosen from list and used for a purchase" do
        visit spree.products_path

        find(:xpath, "//div[@class='product-image']/a").click
        click_button 'Add To Cart'
        click_link 'Checkout'
        fill_in 'First Name', :with => 'Jeff'
        fill_in 'Last Name', :with => 'Squires'
        fill_in 'Street Address', :with => '123 Foo St'
        fill_in 'City', :with => 'Fooville'
        fill_in 'order_bill_address_attributes_state_name',:with => 'Alabama'
                                    
        fill_in 'Zip', :with => '12345'
        fill_in 'Phone', :with => '123-123-1234'
        check "Use Billing Address"

        click_button 'Save and Continue'

        click_button 'Save and Continue'

        page.should have_xpath("//table[@class='existing-credit-card-list']/tbody/tr", :text => @credit_card.last_digits) #, :count => x) 
        choose 'existing_card'
        save_and_open_page

        click_button 'Save and Continue'
        save_and_open_page

        page.should have_content "Ending in #{@credit_card.last_digits}"
      end
    end
  end
end
