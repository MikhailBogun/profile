class Api::V1::SectionsController < ApplicationController
  before_action :authorize_access_request!
  def index
    render json: {test:"okey"}
  end
  def show
    user = current_user;
    query_where = {user_id: user.id}
    profiles = user.isAdmin && params[:all] ? Section.where.not(query_where) : Section.where(query_where);
    render json:{profiles:profiles, username: user.username}
  end


  def update
    updated_data = params[:data][:edit_data];
    profile = Section.find(updated_data[:id]);
    profile.update(
      name:updated_data[:name],
      gender: updated_data[:gender],
      city: updated_data[:city],
      birthdate: updated_data[:birthdate]
    )
    render status: :ok
  end

  def destroy
    item_profile = Section.find(params[:id_profile])
    item_profile.destroy
    render status: :ok
  end
end
