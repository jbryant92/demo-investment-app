require 'spec_helper'

describe Loaders::AssociationLoader do
  describe '#call' do
    let(:campaign) { create(:campaign, investments: [investment_1, investment_2]) }
    let(:investment_1) { create(:investment) }
    let(:investment_2) { create(:investment) }

    context 'when loading the association of a single object' do
      it 'returns the associated objects' do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(Campaign, :investments).load(campaign)
        end
        expect(result).to eq([investment_1, investment_2])
      end
    end
  end
end
