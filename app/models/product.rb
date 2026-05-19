class Product < ApplicationRecord
  belongs_to :vendor, class_name: 'User', optional: true

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }, allow_nil: true
end
