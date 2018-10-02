class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	add_flash_types :error, :warning

	protected

	def configure_permitted_parameters
		accepted_parameters = [
			:first_name, :last_name, :title, :username, :email, :password, :password_confirmation,
			:sms_number, :sms_carrier, :plan
		]
		devise_parameter_sanitizer.for(:sign_up) do |u|
			u.permit *accepted_parameters
		end
		devise_parameter_sanitizer.for(:account_update) do |u|
			u.permit *accepted_parameters, :current_password
		end
	end
end
