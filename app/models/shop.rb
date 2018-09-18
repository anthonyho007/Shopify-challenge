class Shop < ApplicationRecord
  has_secure_password
  validates :name, :password_digest, presence: true
  
  has_many :orders
  has_many :items
end
