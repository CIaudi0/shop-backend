module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def authenticate_user!
    render json: { errors: 'Non autenticato' }, status: :unauthorized unless @current_user
  end

  def set_current_user
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithms: ['HS256']).first
    @current_user = User.find_by(id: payload['user_id'])
    Current.user = @current_user
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
