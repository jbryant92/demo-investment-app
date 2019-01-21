class Resolvers::CreateInvestment < GraphQL::Function
  type Types::InvestmentType
  description 'Creates a new investment on a context'

  argument :campaignId, types.Int, 'The ID of the campaign to apply the investment to'
  argument :amount, types.Float, 'The investment amount'

  def call(_obj, args, _ctx)
    campaign = Campaign.find_by(id: args[:campaignId])
    return GraphQL::ExecutionError.new("Campaign with id: #{args[:campaignId]} not found") unless campaign

    @amount = args[:amount]
    @investment_multiple = campaign.investment_multiple

    return GraphQL::ExecutionError.new("To own a whole number of shares you must enter an amount that is a multiple of £#{@investment_multiple}. Try one of the following:", options: { alternatives: alternatives }) unless valid_amount?

    campaign.investments.create(
      amount: @amount
    )
  end

  private
  def valid_amount?
    result = (@amount % @investment_multiple).round(2)
    result.zero? || result == @investment_multiple
  end

  def alternatives
    if lower == 0.0
      [
        @investment_multiple,
        @investment_multiple * 2
      ]
    else
      [
        lower.round(2),
        upper.round(2)
      ]
    end
  end

  def upper
    (@amount / @investment_multiple).ceil * @investment_multiple
  end

  def lower
    (@amount / @investment_multiple).floor * @investment_multiple
  end
end
