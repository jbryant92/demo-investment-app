class Types::InvestmentType < GraphQL::Schema::Object
  field :id, Integer, null: false
  field :amount, Float, null: false
  field :campaign, Types::CampaignType, null: false
end
