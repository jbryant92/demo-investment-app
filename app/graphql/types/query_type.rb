module Types
  class QueryType < GraphQL::Schema::Object
    field :paginated_campaigns, Types::PaginatedCampaignType, null: true do
      description "Gets all campaigns"
      argument :page, Integer, required: false
      argument :page_size, Integer, required: false
    end

    def paginated_campaigns(page: 1, page_size: 9)
      query = Campaign
        .order(created_at: :desc)
      count = query.count
      query = query
        .offset((page - 1) * page_size)
        .limit(page_size)

        {
          campaigns: query,
          total: count,
          total_pages: (count.to_f / page_size).ceil
        }
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
