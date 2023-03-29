class ApplicationController < ActionController::API
  before_action :set_default_response_format

  # include SimpleEndpoint::Controller
  # include DefaultEndpoint
  # include JWTSessions::RailsAuthorization

  # rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  # private

  # def not_authorized
  #   head(:unauthorized)
  # end

  def set_default_response_format
    request.format = :json unless params[:format]
  end
end
