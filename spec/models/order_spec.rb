require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to :shop }

  it { should have_and_belong_to_many(:items) }

  it { should validate_presence_of :shop_id }
end
