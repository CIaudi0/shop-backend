class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def google_oauth2
    auth = request.env['omniauth.auth']

    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
    end

    access_token = JWT.encode({
      user_id:    user.id,
      email:      auth.info.email,
      first_name: auth.info.first_name&.capitalize,
      last_name:  auth.info.last_name&.capitalize,
      role:       user.role,
      exp:        15.minutes.from_now.to_i
    }, Rails.application.secret_key_base)

    refresh_token = RefreshToken.generate_for(user)

    cookies[:refresh_token] = {
      value:     refresh_token.token,
      httponly:  true,
      expires:   7.days.from_now,
      secure:    Rails.env.production?,
      same_site: Rails.env.production? ? :none : :lax
    }

    frontend_url = ENV.fetch('FRONTEND_URL', 'http://localhost:4200')
    redirect_to "#{frontend_url}/login/success?token=#{access_token}", allow_other_host: true
  end
end
