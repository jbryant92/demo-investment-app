module Types
  class MutationType < GraphQL::Schema::Object
    field :create_investment, function: Resolvers::CreateInvestment.new
  end
end
