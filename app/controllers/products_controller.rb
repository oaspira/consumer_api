class ProductsController < ApplicationController
  def upload
    if params[:file].present?
      ProductImportJob.perform_later(params[:file].path)
      render json: { message: "Import Started!" }, status: :accepted
    else
      render json: { error: "Something bad happen" }, status: :unprocessable_entity
    end
  end

  def index
    products = Product.where(country: params[:country]).group_by(&:product_name)
    render json: products.map { |name, products| { product_name: name, prices: products.map(&:price) } }
  end
end
