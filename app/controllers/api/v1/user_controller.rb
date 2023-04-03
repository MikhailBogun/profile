class Api::V1::UserController < ApplicationController
  before_action :authorize_access_request!, only: [:show, :index, :update, :destroy]
  before_action :require_admin, only: [:update, :index, :destroy]

  def index
      users = user_with_count

      render json: users, status: :ok
  end

  def show
    user = User.select(:id, :username, :email, :isAdmin).find_by(id: params[:id])
    render json: {user: user} ,status: :ok
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

  def update
    updated_data = params[:data][:edit_data];
    user = User.find_by( id:updated_data[:id]);
    if user
      user_query_update(user, updated_data)
      render status: :ok
    else
      render status: :not_found
    end
  end

  def destroy
    item_profile = User.find(params[:id])
    item_profile.destroy
    render status: :ok
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
      SELECT users.id, users.email, users.username, users."isAdmin", COUNT(profiles.id) as profile_count
      FROM users
      LEFT JOIN profiles ON users.id = profiles.user_id
      GROUP BY users.id;
    ')
  end

  def user_query_update(user, updated_data)
    user.update(
      username:updated_data[:username],
      email: updated_data[:email],
      isAdmin: updated_data[:isAdmin]
    ) 
  end
end
