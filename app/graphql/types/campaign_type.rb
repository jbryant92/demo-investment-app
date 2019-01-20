class Types::CampaignType < GraphQL::Schema::Object
  field :id, Integer, null: false
  field :name, String, null: false
  field :image_url, String, null: true
  field :target_amount, Float, null: true
  field :sector, String, null: true
  field :country, Types::CountryType, null: true

  def country
    ::Loaders::AssociationLoader.for(Campaign, :country).load(object)
  end

  field :funded_amount, Float, null: false

  def funded_amount
    @funded_amount ||= investments.then do |association|
      association.pluck(:amount).inject(&:+) || 0.0
    end
  end

  field :percentage_complete, Float, null: false

  def percentage_complete
    funded_amount.then do |amount|
      ((amount / target_amount) * 100).round(2)
    end
  end

  field :number_of_investors, Integer, null: false

  def number_of_investors
    investments.then do |association|
      association.count
    end
  end

  def investments
    ::Loaders::AssociationLoader.for(Campaign, :investments).load(object)
  end
end
