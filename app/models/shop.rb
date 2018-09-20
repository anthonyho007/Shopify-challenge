class Shop < ApplicationRecord
  has_secure_password
  validates :name, :password_digest, presence: true
  
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
end
