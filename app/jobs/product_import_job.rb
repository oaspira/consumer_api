class ProductImportJob < ApplicationJob
  queue_as :default

  def perform(file_path, job_id)
    begin
      data = JSON.parse(File.read(file_path).force_encoding("ISO-8859-1").encode("UTF-8", invalid: :replace, undef: :replace, replace: ""))
    rescue JSON::ParserError => e
      logger.error "JSON parsing error: #{e.message}"
      return
    rescue Errno::ENOENT => e
      logger.error "File not found: #{e.message}"
      return
    end

    delete_previous_record if data.present?

    mongo_products = []
    sql_products = []

    data.each_with_index do |item, index|
      next unless valid_item?(item)

      shop_name = item['ismarketplace'] ? item['marketplaceseller'] : item['site']

      normalized_shop_name = normalize_shop_name(shop_name)
      normalized_country = normalize_country(item['country'])

      product_data = {
        product_id: item['sku'],
        country: normalized_country,
        shop_name: normalized_shop_name,
        product_name: item['model'],
        product_category_id: item['categoryId'],
        price: BigDecimal(item['price'].to_s),
        brand: item['brand'],
        url: item['url']
      }

      mongo_products << product_data
      sql_products << product_data
    end

    MongoProduct.collection.insert_many(mongo_products) unless mongo_products.empty?

    sql_products.each_slice(1000) do |batch|
      SqlProduct.import(batch, on_duplicate_key_ignore: true) unless batch.empty?
    end

    logger.info "Import completed."
  end

  private

  def valid_item?(item)
    item['availability'].present? && item['price'].to_f > 0
  end

  def normalize_shop_name(shop_name)
    shop_name.gsub(/BE|NL|FR/, '').strip
  end

  def normalize_country(country)
    country.gsub(/belgium nl|belgium fr/, 'belgium')
  end

  def delete_previous_record
    SqlProduct.delete_all
    Mongoid::Clients.default[:mongo_products].delete_many({})
  end
end
