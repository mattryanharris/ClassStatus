require 'rails_helper'

describe "Student" do
	let (:student) { FactoryGirl.create(:student) }
	let(:class_session) { FactoryGirl.create :class_session }

	before :each do
		login_as student, scope: :user
	end

	it "should be able to subscribe to a class" do
		visit class_session_path(class_session)

		click_link "Subscribe"

		expect(page).to have_link "Unsubscribe"
	end

	it "should be able to unsubscribe to a class" do
		class_session.subscribers << student

		visit class_session_path(class_session)

		click_link "Unsubscribe"

		expect(page).to have_link "Subscribe"
	end

	describe "should receive notifications when class is cancelled" do
		it "via phone sms"

		it "via e-mail"
	end

	it "should be able to upgrade from free to pro account"
	it "should be able to upgrade account status from free to pro account"
	it "can not subscribe to more than 3 classes unless pro"
end
