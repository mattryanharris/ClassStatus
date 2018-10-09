class NotificationMailer < ActionMailer::Base
  default from: "ClassStatus <notifications@classstatus.co>"

	def cancel(user_id, notification_id)
		@user = User.find user_id
		@notification = Notification.find notification_id

		mail(to: @user.email, subject: "#{@notification.notifiable.name} has been cancelled")
	end
end
