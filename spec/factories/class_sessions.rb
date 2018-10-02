# == Schema Information
#
# Table name: class_sessions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_time :time
#  end_time   :time
#  days       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  location   :string(255)
#  class_code :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :class_session do
		name "MyString"
		teachers { [FactoryGirl.create(:teacher)] }
		start_time "2013-07-18 21:09:40"
		end_time "2013-07-18 21:09:40"
		location "HUM-3"
		days sunday: true, monday: false, tuesday: true, wednesday: false,
			thursday: true, friday: false, saturday: true
	end
end
