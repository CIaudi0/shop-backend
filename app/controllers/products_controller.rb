class ProductsController < ApplicationController
  def index
    page     = [(params[:page] || 1).to_i, 1].max
    per_page = [[(params[:per_page] || 8).to_i, 1].max, 24].min

    scope = Product.all
    if params[:q].present?
      search_term = "%#{params[:q].downcase}%"
      scope = scope.where("LOWER(title) LIKE :search OR LOWER(description) LIKE :search", search: search_term)
    end

    total    = scope.count
    products = scope.order(created_at: :desc).offset((page - 1) * per_page).limit(per_page)

    render json: {
      products: products,
      meta: {
        total:       total,
        page:        page,
        per_page:    per_page,
        total_pages: [(total.to_f / per_page).ceil, 1].max
      }
    }
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end
end
