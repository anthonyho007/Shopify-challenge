require 'rails_helper'

RSpec.describe Lineitem, type: :model do
  it { should respond_to :order_id }
  it { should respond_to :product_id }

  it { should belong_to :order }
  it { should belong_to :product }
end
