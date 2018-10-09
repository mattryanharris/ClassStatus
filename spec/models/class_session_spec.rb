require 'rails_helper'

describe ClassSession do
	it "has valid factories" do
		expect(FactoryGirl.build :class_session).to be_valid
	end

	it "should be invalid without a name" do
		expect(FactoryGirl.build :class_session, name: "").to_not be_valid
	end

	it "should be invalid with a teacher" do
		expect(FactoryGirl.build :class_session, teachers: []).to_not be_valid
	end

	it "should allow days to be accessed by hash" do
		expect(FactoryGirl.build(:class_session).days).to be_kind_of(ActiveSupport::HashWithIndifferentAccess)
	end
end
