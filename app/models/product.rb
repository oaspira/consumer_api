class Product
  include Mongoid::Document

  field :product_id, type: String
  field :product_name, type: String
  field :shop_name, type: String
  field :product_category_id, type: Integer
  field :country, type: String
  field :brand, type: String
  field :price, type: BigDecimal
  field :url, type: String

  validates :product_id, presence: true
  validates :product_name, presence: true
  validates :shop_name, presence: true
  validates :country, presence: true
  validates :brand, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }

  before_save :normalize_data

  private

  def normalize_data
    self.shop_name = shop_name.gsub(/BE|NL|FR/, '').strip
    self.country = country.gsub(/belgium nl|belgium fr/, 'belgium')
  end
end
