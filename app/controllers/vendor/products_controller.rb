class Vendor::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_vendor!

  def create
    product = Product.new(product_params)
    
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    
    if product.update(product_params)
      render json: product
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    
    head :no_content 
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category, :thumbnail)
  end
end