require 'rails_helper'

describe "class_sessions/index" do
  before(:each) do
    assign(:class_sessions, [
      stub_model(ClassSession,
        FactoryGirl.attributes_for(:class_session)
      ),
      stub_model(ClassSession,
        FactoryGirl.attributes_for(:class_session)
      )
    ])
  end

  it "renders a list of class_sessions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select ".class_name>a", count: 2
    assert_select ".class", count: 2
  end
end
