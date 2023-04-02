class Api::V1::ProfileController < ApplicationController
  before_action :authorize_access_request!

  def index
    user = current_user;
    profiles = all_sections(user, params)
    render json:{profiles:profiles, username: user.username}
  end


  def update
    updated_data = params[:data][:edit_data];
    profile = Profile.find(updated_data[:id]);
    profile.update(
      name:updated_data[:name],
      gender: updated_data[:gender],
      city: updated_data[:city],
      birthdate: updated_data[:birthdate]
    )
    render status: :ok
  end

  def destroy
    item_profile = Profile.find(params[:id_profile])
    item_profile.destroy
    render status: :ok
  end

  private

  def all_sections(user, params)
    query_where = {user_id: user.id}
    if user.isAdmin && params[:all]
      Profile.where.not(query_where).order("id DESC")
    else
      Profile.where(query_where).order("id DESC");
    end
  end
end
