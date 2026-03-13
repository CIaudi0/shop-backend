# app/controllers/callbacks_controller.rb
class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def google_oauth2
    auth = request.env['omniauth.auth']
    
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name = auth.info.name
    end

    payload = { 
      user_id: user.id, 
      email: auth.info.email,
      first_name: auth.info.first_name.capitalize,
      last_name: auth.info.last_name.capitalize,
      role: user.role,
      exp: 0.5.hours.from_now.to_i 
    }   
    
    token = JWT.encode(payload, Rails.application.secret_key_base)

    frontend_url = Rails.env.production? ? "http://localhost:8080" : "http://localhost:4200"
    redirect_to "#{frontend_url}/login/success?token=#{token}", allow_other_host: true

  end
end