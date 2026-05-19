class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ', 2)&.last

    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256').first
      @current_user = User.find(decoded['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { errors: 'Non autorizzato. Token mancante o non valido.' }, status: :unauthorized
    end
  end

  def require_admin!
    render json: { errors: 'Accesso negato: Solo Admin' }, status: :forbidden unless @current_user&.admin?
  end

  def require_vendor!
    render json: { errors: 'Accesso negato: Solo Venditori' }, status: :forbidden unless @current_user&.vendor? || @current_user&.admin?
  end

  private

  def not_found
    render json: { errors: 'Risorsa non trovata' }, status: :not_found
  end
end