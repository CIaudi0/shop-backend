class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @items = Current.user.cart_items.includes(:product)
    render json: @items.as_json(include: :product)
  end

  def update_item
    cart_item = @current_user.cart_items.find_by(product_id: params[:product_id])

    if cart_item
      new_quantity = [params[:quantity].to_i, 1].max

      if new_quantity > cart_item.product.stock
        return render json: { errors: "Stock insufficiente (disponibili: #{cart_item.product.stock})" },
                      status: :unprocessable_entity
      end

      cart_item.update!(quantity: new_quantity)
      render json: { message: 'Quantità aggiornata', cart_item: cart_item }
    else
      render json: { errors: 'Prodotto non trovato nel carrello' }, status: :not_found
    end
  end

  def add_item
    product = Product.find_by(id: params[:product_id])
    return render json: { errors: 'Prodotto non trovato' }, status: :not_found unless product

    cart_item = @current_user.cart_items.find_or_initialize_by(product_id: product.id)
    new_quantity = cart_item.new_record? ? 1 : cart_item.quantity + 1

    if new_quantity > product.stock
      return render json: { errors: "Stock esaurito (disponibili: #{product.stock})" },
                    status: :unprocessable_entity
    end

    cart_item.quantity = new_quantity

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

  def sync
    items = params.require(:items)

    ActiveRecord::Base.transaction do
      items.each do |item|
        product = Product.find_by(id: item[:product_id])
        next unless product

        cart_item = Current.user.cart_items.find_or_initialize_by(product_id: item[:product_id])
        new_qty = cart_item.new_record? ? item[:quantity].to_i : cart_item.quantity + item[:quantity].to_i
        cart_item.quantity = [new_qty, product.stock].min
        cart_item.save! if cart_item.quantity > 0
      end
    end

    render json: Current.user.cart_items.includes(:product).map { |ci| { product: ci.product, quantity: ci.quantity } }
  end
end
