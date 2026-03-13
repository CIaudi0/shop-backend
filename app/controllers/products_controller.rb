class ProductsController < ApplicationController
  def index
    if params[:q].present?
      search_term = "%#{params[:q].downcase}%"
      @products = Product.where("LOWER(title) LIKE :search OR LOWER(description) LIKE :search", search: search_term)
    else
      @products = Product.all
    end

    render json: @products.order(created_at: :desc)
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end

end