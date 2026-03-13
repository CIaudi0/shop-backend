class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    items = @current_user.cart_items.includes(:product).map do |item|
      {
        id: item.id,
        quantity: item.quantity,
        product: item.product
      }
    end
    render json: items
  end

  def update_item
    cart_item = @current_user.cart_items.find_by(product_id: params[:product_id])
    
    if cart_item
      new_quantity = [params[:quantity].to_i, 1].max 
      
      cart_item.update!(quantity: new_quantity)
      render json: { message: 'Quantità aggiornata', cart_item: cart_item }
    else
      render json: { errors: 'Prodotto non trovato nel carrello' }, status: :not_found
    end
  end

  def add_item
    cart_item = @current_user.cart_items.find_or_initialize_by(product_id: params[:product_id])
    cart_item.quantity = (cart_item.quantity || 0) + 1
    
    if cart_item.save
      render json: { message: 'Prodotto aggiunto', cart_item: cart_item }
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def remove_item
    cart_item = @current_user.cart_items.find_by(product_id: params[:product_id])
    cart_item&.destroy
    head :no_content
  end
end