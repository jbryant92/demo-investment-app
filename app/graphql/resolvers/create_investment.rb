class Resolvers::CreateInvestment < GraphQL::Function
  type Types::InvestmentType
  description 'Creates a new investment on a context'

  argument :campaignId, types.Int, 'The ID of the campaign to apply the investment to'
  argument :amount, types.Float, 'The investment amount'

  def call(_obj, args, _ctx)
    campaign = Campaign.find_by(id: args[:campaignId])
    return GraphQL::ExecutionError.new("Campaign with id: #{args[:campaignId]} not found") unless campaign

    @amount = args[:amount]
    @investment_multiple = campaign.investment_multiple.to_i
    return GraphQL::ExecutionError.new("To own a whole number of shares you must enter an amount that is a multiple of £#{@investment_multiple.to_i}. Try one of the following:", options: { alternatives: alternatives }) unless @amount % @investment_multiple == 0.0

    campaign.investments.create(
      amount: @amount
    )
  end

  private
  def alternatives
    if lower == 0.0
      [
        @investment_multiple,
        @investment_multiple * 2
      ]
    else
      [
        lower,
        upper
      ]
    end
  end

  def upper
    BigDecimal(@amount.to_i)./(@investment_multiple).ceil * @investment_multiple
  end

  def lower
    BigDecimal(@amount.to_i)./(@investment_multiple).floor * @investment_multiple
  end
end
