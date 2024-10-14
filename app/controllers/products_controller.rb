class ProductsController < ApplicationController
  def upload
    if params[:file].present?
      job_id = SecureRandom.uuid
      ProductImportJob.perform_later(params[:file].path, job_id)
      render json: { message: "Import Started!", job_id: job_id }, status: :accepted
    else
      render json: { error: "Error" }, status: :unprocessable_entity
    end
  end

  def index
    per_page = (params[:per_page] || 10).to_i
    page = (params[:page] || 1).to_i
    country_filter = params[:country].presence

    sql_products = fetch_sql_products(country_filter, page, per_page)
    mongo_products = fetch_mongo_products(country_filter, page, per_page)

    combined_products = sql_products.to_a + mongo_products.to_a
    total_count = count_total_products(country_filter)

    render json: {
      products: combined_products,
      total_pages: (total_count / per_page.to_f).ceil,
      current_page: page
    }
  end

  private

  def fetch_sql_products(country, page, per_page)
    scope = country ? SqlProduct.where(country: country) : SqlProduct
    scope.paginate(page: page, per_page: per_page)
  end

  def fetch_mongo_products(country, page, per_page)
    scope = country ? MongoProduct.where(country: country) : MongoProduct
    scope.skip((page - 1) * per_page).limit(per_page)
  end

  def count_total_products(country)
    total_sql_count = country ? SqlProduct.where(country: country).count : SqlProduct.count
    total_mongo_count = country ? MongoProduct.where(country: country).count : MongoProduct.count
    total_sql_count + total_mongo_count
  end

end
