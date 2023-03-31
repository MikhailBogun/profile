class Api::V1::RegistrationsController < ApplicationController
  def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?)
      @current_user = user
      render json: { token: tokens[:access], user: { id:user.id, username:user.username}}
    else
      render json: "Invalid email or password", status: :unauthorized
    end
  end

  def destroy
    authorize_access_request!
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render status: :ok
  end
end
