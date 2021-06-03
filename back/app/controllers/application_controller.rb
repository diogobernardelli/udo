class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include APICommonResponses

  rescue_from JWTSessions::Errors::Unauthorized, with: :render_unauthorized_error

  private

    def current_user
      @current_user ||= User.find(payload['user_id'])
    end

    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
end
