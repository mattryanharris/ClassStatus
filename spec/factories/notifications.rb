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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :cancel_notification, class: Notification::Cancel do
		type "cancel"
		date  Date.today
		association :notifiable, factory: :class_session
	end
end
