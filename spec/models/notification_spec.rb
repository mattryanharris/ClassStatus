require 'rails_helper'

describe Notification do
	it "has valid factories" do
		expect(FactoryGirl.build :cancel_notification).to be_valid
	end
end
