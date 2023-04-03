class Api::V1::DashboardsController < ApplicationController
  before_action :authorize_access_request!
  before_action :require_admin, only: [:index]

  def show
    counts = {
      count_user: User.count(),
      count_profiles:  Profile.count(),
      count_profiles_with_age:user_and_profiles_counts
    }
    render json: counts
  end

  private

  def user_and_profiles_counts
    Profile.where('DATE_PART(\'year\', age(birthdate)) >= ?', 18).count()
  end
end
