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
    render json: order.as_json(include: { order_items: { include: :product } })
  end

  def create
    cart_items = @current_user.cart_items.includes(:product)

    return render json: { errors: 'Il carrello è vuoto' }, status: :unprocessable_entity if cart_items.empty?

    errors = validate_order_params
    return render json: { errors: errors }, status: :unprocessable_entity if errors.any?

    if cart_items.any? { |item| item.product.nil? }
      return render json: { errors: 'Alcuni prodotti non sono più disponibili' }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      total = cart_items.sum { |item| item.product.price * item.quantity }

      @order = @current_user.orders.create!(
        customer: params.require(:customer).permit(:firstName, :lastName, :email).to_h,
        address: params.require(:address).permit(:street, :city, :zip).to_h,
        total: total,
        status: 'completato'
      )

      cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end

      cart_items.destroy_all
    end

    render json: @order, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def validate_order_params
    errors = []
    c = params[:customer]
    a = params[:address]

    errors << 'Nome cliente mancante'  if c.blank? || c[:firstName].blank?
    errors << 'Cognome cliente mancante' if c.blank? || c[:lastName].blank?
    errors << 'Email cliente mancante'  if c.blank? || c[:email].blank?
    errors << 'Via mancante'            if a.blank? || a[:street].blank?
    errors << 'Città mancante'          if a.blank? || a[:city].blank?
    errors << 'CAP mancante'            if a.blank? || a[:zip].blank?

    errors
  end
end