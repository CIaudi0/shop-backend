class ApplicationController < ActionController::API
  include ActionController::Cookies 
  
  include Authentication

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :handle_duplicate_record

  def require_admin!
    unless Current.user&.admin?
      render json: { errors: 'Accesso negato: Solo Admin' }, status: :forbidden
    end
  end

  def require_vendor!
    unless Current.user&.vendor? || Current.user&.admin?
      render json: { errors: 'Accesso negato: Solo Venditori' }, status: :forbidden
    end
  end

  private

  def not_found
    render json: { errors: 'Risorsa non trovata' }, status: :not_found
  end

  def handle_duplicate_record
    render json: { errors: 'Richiesta duplicata elaborata con successo.' }, status: :conflict
  end
end