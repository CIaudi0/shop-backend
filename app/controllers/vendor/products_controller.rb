class Vendor::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_vendor!
  before_action :set_own_product, only: [:update, :destroy]

  def create
    product = @current_user.products.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      head :no_content
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_own_product
    @product = @current_user.admin? ? Product.find(params[:id]) : @current_user.products.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Prodotto non trovato o accesso non autorizzato' }, status: :forbidden
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :original_price, :sale, :thumbnail)
  end
end