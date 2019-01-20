class Campaign < ApplicationRecord
  has_many :investments, dependent: :destroy
  belongs_to :country
end
