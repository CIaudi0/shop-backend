class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    users = User.all.select(:id, :name, :email, :role)
    render json: users
  end

  def update
    user = User.find(params[:id])
    
    if user.update(role: params[:role])
      render json: { message: 'Ruolo aggiornato', user: user }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    
    if user.destroy
      render json: { message: 'Utente eliminato' }
    else
      render json: { errors: 'Impossibile eliminare l\'utente' }, status: :unprocessable_entity
    end
  end
end