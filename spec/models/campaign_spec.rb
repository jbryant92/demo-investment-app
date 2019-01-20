require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { should belong_to :country }
  it { should have_many :investments }
end
