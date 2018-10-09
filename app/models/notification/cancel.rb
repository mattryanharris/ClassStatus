# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  type            :string(255)
#  notifiable_id   :integer
#  notifiable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  extra_data      :string(255)
#

class Notification::Cancel < Notification
	composed_of :date,
		:class_name => 'Date',
		:mapping => [%w(extra_data to_s)],
		:constructor => Proc.new{ |item| item },
		:converter => Proc.new{ |item| item }

	def date
		Date.parse self.extra_data unless self.extra_data.blank?
	end

	def issue_to(users)
		users.each do |user|
			NotificationMailer.cancel(user.id, self.id).deliver unless user.email.blank?
			NotificationTexter.cancel(user.id, self.id) unless user.sms_number.blank?
		end
	end
end
