class Types::PaginatedCampaignType < GraphQL::Schema::Object
  field :campaigns, [Types::CampaignType], null: false
  field :total, Integer, null: false
  field :total_pages, Integer, null: false
end
