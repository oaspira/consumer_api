class SqlProduct < ApplicationRecord
  self.table_name = 'products'

  validates :product_id, presence: true, uniqueness: true
  validates :product_name, presence: true
  validates :shop_name, presence: true
  validates :country, presence: true
  validates :brand, presence: true
  validates :price, numericality: { greater_than: 0 }
end
