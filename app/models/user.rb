class User < ApplicationRecord
  enum :role, { user: 0, admin: 1, vendor: 2 }

  validates :email, presence: true, uniqueness: true

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :products, foreign_key: :vendor_id, dependent: :nullify, inverse_of: :vendor
  has_many :refresh_tokens, dependent: :destroy
end