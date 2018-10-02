require 'rails_helper'

feature "Notifications" do
	scenario "teachers cancel a specific class" do
		expect "all student accounts subscribed to the class to receive notification"
		expect "class status on the website of the class to change"
	end
end
