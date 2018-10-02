require 'rails_helper'

describe User do
	it "has valid factories" do
		expect(FactoryGirl.build :user).to be_valid
		expect(FactoryGirl.build :student).to be_valid
		expect(FactoryGirl.build :teacher).to be_valid
	end
end
