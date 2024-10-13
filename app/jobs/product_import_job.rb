class ProductImportJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    begin
      data = JSON.parse(File.read(file_path).force_encoding("ISO-8859-1").encode("UTF-8", invalid: :replace, undef: :replace, replace: ""))
    rescue JSON::ParserError => e
      logger.error "JSON parsing error: #{e.message}"
      return
    rescue Errno::ENOENT => e
      logger.error "File not found: #{e.message}"
      return
    end

    data.each do |item|
      next unless valid_item?(item)

      shop_name = item['ismarketplace'] ? item['marketplaceseller'] : item['site']

      mongo_product = MongoProduct.find_or_initialize_by(product_id: item['sku']) do |product|
        product.country = item['country']
        product.shop_name = shop_name
        product.product_name = item['model']
        product.product_category_id = item['categoryId']
        product.price = BigDecimal(item['price'].to_s)
        product.brand = item['brand']
        product.url = item['url']
      end

      sql_product = SqlProduct.find_or_initialize_by(product_id: item['sku']) do |product|
        product.country = item['country']
        product.shop_name = shop_name
        product.product_name = item['model']
        product.product_category_id = item['categoryId']
        product.price = BigDecimal(item['price'].to_s)
        product.brand = item['brand']
        product.url = item['url']
      end

      if mongo_product.changed? || sql_product.changed?
        mongo_product.save!
        sql_product.save!
      end
    end

    logger.info "Import completed."
  end

  private

  def valid_item?(item)
    item['availability'].present? && item['price'].to_f > 0
  end
end
