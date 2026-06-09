class Product < ApplicationRecord
  belongs_to :vendor, class_name: 'User', optional: true

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_nil: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
