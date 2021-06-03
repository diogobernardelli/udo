module APICommonResponses
	extend ActiveSupport::Concern

	def render_success(data={},message=I18n.t('api_success.default'))
		default = { status: 200, message: message }
		response = default.merge(data)
		render json: response, status: :ok
	end

	def render_unprocessable_entity_error(error=I18n.t('api_errors.render_unprocessable_entity'))
		response = { status: 422, error: error }
		render json: response, status: :unprocessable_entity
	end

	def render_already_exists(data={})
		default = { status: 409, error: I18n.t('api_errors.already_exists') }
		response = default.merge(data)
		render json: response, status: :conflict
	end

	def render_not_found_error(error=I18n.t('api_errors.render_not_found'))
		response = { status: 404, error: error }
		render json: response, status: :not_found
	end

	def render_unauthorized_error()
		response = { status: 401, error: I18n.t('api_errors.render_unauthorized') }
		render json: response, status: :unauthorized
	end

end