require 'rails_helper'

describe "class_sessions/edit" do
  before(:each) do
    @class_session = assign(:class_session, stub_model(ClassSession,
      FactoryGirl.attributes_for(:class_session)
    ))
  end

  it "renders the edit class_session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", class_session_path(@class_session), "post" do
      assert_select "input#class_session_name[name=?]", "class_session[name]"
      assert_select "input#class_session_days_sunday[name=?]", "class_session[days][sunday]"
      assert_select "input#class_session_days_monday[name=?]", "class_session[days][monday]"
      assert_select "input#class_session_days_tuesday[name=?]", "class_session[days][tuesday]"
      assert_select "input#class_session_days_wednesday[name=?]", "class_session[days][wednesday]"
      assert_select "input#class_session_days_thursday[name=?]", "class_session[days][thursday]"
      assert_select "input#class_session_days_friday[name=?]", "class_session[days][friday]"
      assert_select "input#class_session_days_saturday[name=?]", "class_session[days][saturday]"
    end
  end
end
