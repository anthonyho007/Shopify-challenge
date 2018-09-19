require 'rails_helper'

RSpec.describe Placement, type: :model do
  it { should respond_to :order_id }
  it { should respond_to :item_id }

  it { should belong_to :order }
  it { should belong_to :item }
end
