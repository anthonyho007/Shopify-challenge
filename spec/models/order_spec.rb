require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to :shop }

  it { should have_many(:placements) }
  it { should have_many(:items).through(:placements) }

  it { should validate_presence_of :shop_id }
end
