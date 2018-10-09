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

class Notification < ActiveRecord::Base
	belongs_to :notifiable, polymorphic: true
end
