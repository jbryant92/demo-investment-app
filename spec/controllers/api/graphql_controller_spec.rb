require 'rails_helper'

RSpec.describe Api::GraphqlController, type: :controller do
  describe '#execute' do
    subject { post :execute, params: { query: query, variables: variables, operationName: operation_name }, format: :json }
    context 'when querying a campaign' do
      let(:variables) { { id: campaign.id } }
      let(:campaign) { create(:campaign) }
      let(:query) { "query getCampaign($id: ID!) {\n  campaign(id: $id) {\n    id\n    name\n    sector\n    imageUrl\n    country {\n      name\n    }\n    targetAmount\n    fundedAmount\n    percentageComplete\n    numberOfInvestors\n  }\n}\n" }
      let(:operation_name) { "getCampaign" }
      let(:expected_result) do
        {
          'data'=>{
            'campaign'=>{
              'id' => campaign.id,
              'name' => campaign.name,
              'sector' => campaign.sector,
              'imageUrl' => nil,
              'country' => { 'name' => campaign.country.name },
              'targetAmount' => campaign.target_amount,
              'fundedAmount' => 0.0,
              'percentageComplete' => 0.0,
              'numberOfInvestors' => 0
            }
          }
        }
      end

      it 'it returns the correct response' do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(expected_result)
      end

      context 'when the campaign has investments' do
        let(:campaign) do
          create(
            :campaign,
            investments: [investment_1, investment_2],
            target_amount: 2000
          )
        end
        let(:investment_1) { create(:investment, amount: 100) }
        let(:investment_2) { create(:investment, amount: 300) }

        let(:expected_result) do
          {
            'data'=>{
              'campaign'=>{
                'id' => campaign.id,
                'name' => campaign.name,
                'sector' => campaign.sector,
                'imageUrl' => nil,
                'country' => { 'name' => campaign.country.name },
                'targetAmount' => campaign.target_amount,
                'fundedAmount' => 400.0,
                'percentageComplete' => 20.0,
                'numberOfInvestors' => 2
              }
            }
          }
        end

        it 'it returns the correct response' do
          subject
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end
    end

    context 'when querying investments' do
      let(:variables) { { id: investment.id } }
      let(:investment) { create(:investment) }
      let(:query) { "query getInvestment($id: ID!) {\n  investment(id: $id) {\n    amount\n    campaign {\n      name\n      sector\n      fundedAmount\n      numberOfInvestors\n    }\n  }\n}\n" }
      let(:operation_name) { "getInvestment" }

      let(:expected_result) do
        {
          'data' => {
            'investment' => {
              'amount' => investment.amount,
              'campaign' => {
                'fundedAmount' => investment.amount,
                'name' => investment.campaign.name,
                'numberOfInvestors' => 1,
                'sector' => investment.campaign.sector
              }
            }
          }
        }
      end

      it 'it returns the correct response' do
        subject
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(expected_result)
      end
    end

    context 'when querying campaigns' do
      let(:variables) { "{\"page\":#{page},\"pageSize\":2}" }
      let(:page) { 1 }
      let(:query) { "query getCampaigns($page: Int!, $pageSize: Int!) {\n  paginatedCampaigns(page: $page, pageSize: $pageSize) {\n    campaigns{\n      id\n    }\n    total\n  \ttotalPages\n  }\n}" }
      let(:operation_name) { "getCampaigns" }

      let!(:campaign_1) { create(:campaign) }
      let!(:campaign_2) { create(:campaign) }
      let!(:campaign_3) { create(:campaign) }

      context 'when on page 1' do
        let(:page_one_result) do
          {
            'data' => {
              'paginatedCampaigns' => {
                'campaigns' => [
                  { 'id' => campaign_1.id },
                  { 'id' => campaign_2.id }
                ],
                'total' => 3,
                'totalPages' => 2
              }
            }
          }
        end

        it 'it returns the correct response' do
          subject
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq(page_one_result)
        end
      end

      context 'on page 2' do
        let(:page) { 2 }
        let(:page_one_result) do
          {
            'data' => {
              'paginatedCampaigns' => {
                'campaigns' => [
                  { 'id' => campaign_3.id }
                ],
                'total' => 3,
                'totalPages' => 2
              }
            }
          }
        end

        it 'it returns the correct response' do
          subject
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq(page_one_result)
        end

      end
    end
  end
end
