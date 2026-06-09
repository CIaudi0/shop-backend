class RefreshTokensController < ApplicationController
  skip_before_action :set_current_user

  def create
    token_value = cookies[:refresh_token]

    unless token_value
      return render json: { errors: 'Refresh token mancante' }, status: :unauthorized
    end

    refresh_token = RefreshToken.find_by(token: token_value)

    if refresh_token.nil? || refresh_token.expired?
      refresh_token&.destroy
      cookies.delete(:refresh_token)
      return render json: { errors: 'Refresh token non valido o scaduto' }, status: :unauthorized
    end

    user = refresh_token.user

    # Rotation: ogni refresh genera un nuovo token (sicurezza)
    refresh_token.destroy
    new_refresh_token = RefreshToken.generate_for(user)

    cookies[:refresh_token] = {
      value:     new_refresh_token.token,
      httponly:  true,
      expires:   7.days.from_now,
      secure:    Rails.env.production?,
      same_site: Rails.env.production? ? :none : :lax
    }

    access_token = JWT.encode({
      user_id:    user.id,
      email:      user.email,
      first_name: user.name&.split(' ')&.first,
      last_name:  user.name&.split(' ')&.last,
      role:       user.role,
      exp:        15.minutes.from_now.to_i
    }, Rails.application.secret_key_base)

    render json: { token: access_token }
  end

  def destroy
    token_value = cookies[:refresh_token]
    if token_value
      RefreshToken.find_by(token: token_value)&.destroy
      cookies.delete(:refresh_token)
    end
    head :no_content
  end
end
