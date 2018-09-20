require 'rails_helper'

RSpec.describe Shop, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :password_digest }
  it { should have_many(:orders) }
  it { should have_many(:products) }
end
