module Api
  module V1
    class SettingsController < ApplicationController
			before_action :authorize_access_request!
			before_action :set_setting, only: [:toogle_alert]

      def toogle_alert
				if @setting.update(alerts: !@setting.alerts)
          render_success({
            item: @setting,
            message: I18n.t('api_success.settings_updated', status: @setting.alerts.present? ? 'On' : 'Off')
          })
        else
          render_unprocessable_entity_error(@setting.errors.full_messages.join(' '))
        end
      end

      private
        def set_setting
          @setting = current_user.setting
          render_not_found_error(I18n.t('api_errors.render_not_found', class: 'Setting')) if @setting.blank?
        end
    end
  end
end