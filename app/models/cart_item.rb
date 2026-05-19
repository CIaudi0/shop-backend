class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, uniqueness: { scope: :user_id }
end
