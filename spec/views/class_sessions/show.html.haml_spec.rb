require 'rails_helper'

describe "class_sessions/show" do
  before(:each) do
    @class_session = assign(:class_session, stub_model(ClassSession,
      FactoryGirl.attributes_for(:class_session)
    ))
  end
end
