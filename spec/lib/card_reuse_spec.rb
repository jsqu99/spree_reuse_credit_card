require 'spec_helper'

describe CardReuse do
  let(:fixture) {
    Object.new.extend(CardReuse)
  }

  describe '#all_cards_for_user' do
    context 'when user is nil' do
      subject { fixture.all_cards_for_user(nil) }
      it { should be_nil }
    end

    context 'with a valid user' do
      let(:user) { mock(:user) }

      context 'with payments' do
        let(:reuseable_source) {
          mock(:reuseable_source).tap do |source|
            fixture.stub(:valid_for_reuse?).with(source).and_return(true)
          end
        }

        let(:non_reuseable_source) {
          mock(:non_reuseable_source).tap do |source|
            fixture.stub(:valid_for_reuse?).with(source).and_return(false)
          end
        }

        let(:first_reusable_payment) {
          mock(:first_reusable_payment).tap do |payment|
            payment.stub(:source).and_return(reuseable_source)
          end
        }

        let(:second_reusable_payment) {
          mock(:second_reusable_payment).tap do |payment|
            payment.stub(:source).and_return(reuseable_source)
          end          
        }

        let(:non_reusable_payment) {
          mock(:non_reusable_payment).tap do |payment|
            payment.stub(:source).and_return(non_reuseable_source)
          end
        }

        before do
          fixture.stub(:credit_card_payments_for_user).with(user).and_return([
            first_reusable_payment,
            second_reusable_payment, 
            non_reusable_payment
          ])
        end

        subject(:sources) {
          fixture.all_cards_for_user(user)
        }

        it 'does not return sources for payments that cannot be reused' do
          expect(sources).to_not include(non_reuseable_source)
        end

        it 'returns sources for payments that can be reused' do
          expect(sources).to include(reuseable_source)
        end

        it 'only returns each source once' do
          expect(sources.length).to eq(1)
        end
      end
    end
  end
end
