class Api::V1::UserController < ApplicationController
  before_action :authorize_access_request!, only: [:show, :index]

  def index
    if current_user.isAdmin
      users = user_with_count
      render json: users, status: :ok
    else
      render status: :not_acceptable
    end
  end

  def create
    if validates_user?(params)
      @current_user = create_user(params)
      @current_user.save
      token = generate_tokens(@current_user)
      render json: {token: token, user: {id: @current_user.id, username:@current_user.id }}, status: 201
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

  def user_with_count
    User.find_by_sql('
      SELECT users.id, users.email, users.username, users."isAdmin", COUNT(sections.id) as profile_count
      FROM users
      LEFT JOIN sections ON users.id = sections.user_id
      GROUP BY users.id;
    ')
  end
end
