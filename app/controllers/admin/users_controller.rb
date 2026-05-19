class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    users = User.all.select(:id, :name, :email, :role)
    render json: users
  end

  def update
    user = User.find(params[:id])
    return render json: { errors: 'Non puoi modificare il tuo ruolo' }, status: :forbidden if user.id == @current_user.id

    user.update!(role: params[:role])
    render json: { message: 'Ruolo aggiornato', user: user }
  rescue ArgumentError
    render json: { errors: "Ruolo non valido: #{params[:role]}" }, status: :unprocessable_entity
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    user = User.find(params[:id])
    return render json: { errors: 'Non puoi eliminare il tuo account' }, status: :forbidden if user.id == @current_user.id

    user.destroy
    render json: { message: 'Utente eliminato' }
  end
end