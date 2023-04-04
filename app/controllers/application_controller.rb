class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  before_action :set_default_response_format

  # include SimpleEndpoint::Controller
  # include DefaultEndpoint
  # include JWTSessions::RailsAuthorization

  # rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  # private

  # def not_authorized
  #   head(:unauthorized)
  # end



  private

  def require_admin
    current_user
    render status:method_not_allowed unless @current_user.isAdmin 
  end

  def current_user
    @current_user ||= User.find(payload['user_id'])
    return @current_user
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def set_default_response_format
    request.format = :json unless params[:format]
  end
end
