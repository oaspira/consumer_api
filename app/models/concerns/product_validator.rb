module ProductValidator
  extend ActiveSupport::Concern

  included do
    validates :product_id, presence: true, uniqueness: true
    validates :product_name, presence: true
    validates :shop_name, presence: true
    validates :country, presence: true
    validates :brand, presence: true
    validates :price, numericality: { greater_than: 0 }

    before_save :normalize_data
  end

  private

  def normalize_data
    self.shop_name = shop_name.gsub(/BE|NL|FR/, '').strip
    self.country = country.gsub(/belgium nl|belgium fr/, 'belgium')
  end
end
