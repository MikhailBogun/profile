require 'date'

class Api::V1::ProfileController < ApplicationController
  before_action :authorize_access_request!
  before_action :require_admin, only: [:index]


  def index
    user = current_user;
    all_profiles = profiles(user: user, params: params, all:true)
    render json:{profiles:all_profiles, username: user.username}
  end

  def show
    user = current_user;
    user_profiles = profiles(user: user, params: params)
    render json:{profiles:user_profiles, username: user.username}
  end


  def create
    created_profile = create_profile(params[:data][:edit_data])
    if created_profile.save
      render status: :ok
    else
      render status: :not_found
    end
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

  def create_profile(data)
    Profile.new(name: data[:name], birthdate: data[:birthdate], city: data[:city], gender: data[:gender], user_id: current_user.id)
  end

  def destroy
    item_profile = Profile.find(params[:id_profile])
    item_profile.destroy
    render status: :ok
  end

  private

  def profiles(user:, params:, all: nil)
    query_where = {user_id: params[:id] ? params[:id] : user.id}
    if user.isAdmin && all
      Profile.where.not(query_where).order("id DESC")
    else
      Profile.where(query_where).order("id DESC");
    end
  end
end
