class Api::V1::SectionsController < ApplicationController
  before_action :authorize_access_request!
  def index
    render json: {test:"okey"}
  end
  def show
    user = current_user
    profiles = Section.where({user_id: user.id})
    render json:{profiles:profiles, username: user.username}
  end
end