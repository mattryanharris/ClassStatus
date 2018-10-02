class NotificationTexter < Texter
	def cancel(user_id, notification_id)
		@user = User.find user_id
		@notification = Notification.find notification_id

		text to: @user.sms_number, carrier: @user.sms_carrier, method: (@user.pro? ? "sms" : "email"), message: "#{@notification.notifiable.name} has been cancelled for #{@notification.date.strftime "%m/%d/%y"}."
	end
end
