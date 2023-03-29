class Api::V1::UsersController < ApplicationController
  def show
    @users = User.all;
    render json: @users
  end
end
