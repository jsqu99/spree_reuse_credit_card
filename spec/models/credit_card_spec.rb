require 'spec_helper'

#describe Spree::CreditCard do
#
#  let(:valid_credit_card_attributes) { {:number => '4111111111111111', :verification_value => '123', :month => 12, :year => (Time.now.year + 1)} }
#
#  before(:each) do
#
#    @order = Factory(:order)
#    @credit_card = Spree::CreditCard.new
#    @payment = Spree::Payment.create(:amount => 100, :order => @order)
#
#    @success_response = mock('gateway_response', :success? => true, :authorization => '123', :avs_result => {'code' => 'avs-code'})
#    @fail_response = mock('gateway_response', :success? => false)
#
#    @payment_gateway = mock_model(Spree::PaymentMethod,
#                                  :payment_profiles_supported? => true,
#                                  :authorize => @success_response,
#                                  :purchase => @success_response,
#                                  :capture => @success_response,
#                                  :void => @success_response,
#                                  :credit => @success_response,
#                                  :environment => 'test'
#                                  )
#
#    @payment.stub :payment_method => @payment_gateway
#  end
#end
#
