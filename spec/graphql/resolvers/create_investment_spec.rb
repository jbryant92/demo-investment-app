require 'spec_helper'

describe Resolvers::CreateInvestment do
  describe '#call' do
    subject { described_class.new }
    let(:campaign) { create(:campaign, investment_multiple: 30) }
    let(:args) { { campaignId: campaign.id, amount: amount } }
    let(:amount) { 30 }

    context 'when the investment amount is valid' do
      it 'creates a new investment' do
        expect{ subject.call({}, args, {}) }.to change{ Investment.count }.by(1)
      end

      it 'returns the created investment' do
        expect(
          subject.call({}, args, {})
            .attributes
            .except('created_at', 'updated_at', 'id')
        ).to eq( {'campaign_id' => campaign.id, 'amount' => amount } )
      end
    end

    context 'when the campaign cannot be found' do
      let(:args) { { campaignId: -1 } }
      it 'does not create a new investment' do
        expect{ subject.call({}, args, {}) }.to change{ Investment.count }.by(0)
      end

      it 'returns GraphQL execution error with correct message' do
        returned_object = subject.call({}, args, {})
        expect(returned_object.class).to eq( GraphQL::ExecutionError )
        expect(returned_object.message).to eq('Campaign with id: -1 not found')
      end
    end

    context 'when the amount is not a multipler of the investment multiple' do
      let(:amount) { 205 }
      it 'does not create a new investment' do
        expect{ subject.call({}, args, {}) }.to change{ Investment.count }.by(0)
      end

      it 'returns GraphQL execution error with correct message' do
        returned_object = subject.call({}, args, {})
        expect(returned_object.class).to eq( GraphQL::ExecutionError )
        expect(returned_object.message).to eq('To own a whole number of shares you must enter an amount that is a multiple of £30. Try one of the following:')
        expect(returned_object.options).to eq({ alternatives: [180, 210] })
      end

      context 'when the amount is close to 0' do
        let(:amount) { 20 }

        it 'does not give 0 as an option' do
          expect(subject.call({}, args, {}).options).to eq({ alternatives: [30, 60] })
        end
      end
    end
  end
end
