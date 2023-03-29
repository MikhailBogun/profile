class Api::V1::RegistrationController < ApplicationController
  def create
    if validates_user?(params)
      @current_user = create_user(params) if validates_user?(params)      
      if validates_password?(current_user, params)
        @current_user.save
        data = generate_tokens(@current_user)
        render json: data, status: 201
      else
        render status: 412
      end
    else
      render status: 409
    end
  end

  private

  def validates_user?(params)
    User.where(username: params[:username]).or(User.where(email: params[:email])).nil?
  end

  def create_user(params)
    User.new(username: params[:username], password: params[:password], email:params[:email], isAdmin: params[:isAdmin])
  end

  def validates_password?(user:, params:)
    user.valid_password?(params[:password_confirmation])
  end

  def generate_tokens(user:)
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    session.login
  end
end
