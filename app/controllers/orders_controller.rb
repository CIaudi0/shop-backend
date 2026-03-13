class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = @current_user.orders.order(created_at: :desc).map do |order|
      {
        id: order.id,
        created_at: order.created_at,
        status: order.status,
        total: order.total.to_f
      }
    end
    render json: orders
  end

  def show
    order = @current_user.orders.includes(order_items: :product).find(params[:id])
    render json: order.as_json(
      include: { order_items: { include: :product } }
    )
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Ordine non trovato' }, status: :not_found
  end

  def create
    cart_items = @current_user.cart_items.includes(:product)

    if cart_items.empty?
      return render json: { errors: 'Il carrello è vuoto' }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      @order = @current_user.orders.create!(
        customer: params[:customer].as_json, 
        address: params[:address].as_json,   
        total: 0, 
        status: 'completato'
      )

      calculated_total = 0

      cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
        
        calculated_total += (item.product.price * item.quantity)
      end

      @order.update!(total: calculated_total)

      cart_items.destroy_all
    end

    render json: @order, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end