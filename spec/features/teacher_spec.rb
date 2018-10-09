require 'rails_helper'

describe "Teacher" do
	let(:teacher) { FactoryGirl.create :teacher }
	before :each do
		login_as teacher, scope: :user
	end
	it "should be able to create a class profile" do
		visit new_class_session_path

		fill_in "Name", with: "Sasquatch Hunting"
		# select Time.now, from: "Start time"
		select_time Time.now, from: "End time", ampm: true
		check "class_session_days_tuesday"
		check "class_session_days_thursday"

		expect {
			click_button "Submit"
		}.to change{ ClassSession.count }.by(1)
	end

	it "should be able to cancel a specific class ran by the teacher" do
		@class_session = FactoryGirl.create :class_session, teachers: [teacher]
		visit cancel_class_session_path(@class_session)

		select_date Date.today, from: :notification_cancel_date

		expect {
			click_button "Cancel"
		}.to change{ @class_session.notifications.where(type: Notification::Cancel).count }.by(1)
	end
end
