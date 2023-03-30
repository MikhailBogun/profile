class Api::V1::UsersController < ApplicationController
  before_action :authorize_access_request!, only: [:show]

  def show
    @users = User.all;
    render json: @users
  end

  def create
    if validates_user?(params)
      @current_user = create_user(params)
      @current_user.save
      token = generate_tokens(@current_user)
      render json: token, status: 201
    else
      render status: 409
    end
  end

  private

  def validates_user?(params)
    User.find_by(username: params[:username]).nil? && User.find_by(email: params[:email]).nil?
  end

  def create_user(params)
    User.new(username: params[:username], password: params[:password], email:params[:email], isAdmin: params[:isAdmin])
  end

  def generate_tokens(user)
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    session.login.to_json
  end
end
