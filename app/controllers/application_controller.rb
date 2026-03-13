class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session 
  
  allow_browser versions: :modern
  
  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
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
    is_authorized = @current_user&.vendor? || @current_user&.admin?
    render json: { errors: 'Accesso negato: Solo Venditori' }, status: :forbidden unless is_authorized
  end
  
  stale_when_importmap_changes
end