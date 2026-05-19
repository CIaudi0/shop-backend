class User < ApplicationRecord
  enum :role, { user: 0, admin: 1, vendor: 2 }

  validates :email, presence: true, uniqueness: true

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
end