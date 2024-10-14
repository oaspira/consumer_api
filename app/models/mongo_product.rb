class MongoProduct
  include Mongoid::Document
  store_in collection: 'mongo_products'

  field :product_id, type: String
  field :product_name, type: String
  field :shop_name, type: String
  field :product_category_id, type: Integer
  field :country, type: String
  field :brand, type: String
  field :price, type: BigDecimal
  field :url, type: String
end
