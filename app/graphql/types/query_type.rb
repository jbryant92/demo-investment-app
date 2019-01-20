module Types
  class QueryType < GraphQL::Schema::Object
    field :campaigns, [Types::CampaignType], null: true do
      description "Gets all campaigns"
    end

    def campaigns
      Campaign.all
    end

    field :campaign, Types::CampaignType, null: true do
      description "Find a campaign by id"
      argument :id, ID, required: true
    end

    def campaign(id:)
      Campaign.find_by(id: id)
    end

    field :investment, Types::InvestmentType, null: true do
      description "Find a investment by id"
      argument :id, ID, required: true
    end

    def investment(id:)
      Investment.find_by(id: id)
    end
  end
end
