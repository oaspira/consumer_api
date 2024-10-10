class ProductImportJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    data = JSON.parse(File.read(file_path))

    data.each do |item|
      next unless item['availability'] && item['price'].to_f > 0

      shop_name = item['ismarketplace'] ? item['marketplaceseller'] : item['site']
      product = Product.find_or_initialize_by(
        product_id: item['sku'],
        country: item['country'],
        shop_name: shop_name
      )

      product.assign_attributes(
        product_name: item['model'],
        product_category_id: item['categoryId'],
        price: BigDecimal(item['price'].to_s),
        brand: item['brand'],
        url: item['url']
      )

      product.save!
    end
  end
end
