require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to :shop }

  it { should have_many(:lineitems) }
  it { should have_many(:products).through(:lineitems) }

  it { should validate_presence_of :shop_id }
end
