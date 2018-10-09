require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ClassSessionsController do

  # This should return the minimal set of attributes required to create a valid
  # ClassSession. As you add validations to ClassSession, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:class_session).except(:teachers) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClassSessionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
		before do sign_in FactoryGirl.create :student end

    it "assigns all class_sessions as @class_sessions" do
      class_session = FactoryGirl.create :class_session
      get :index, {}, valid_session
      expect(assigns :class_sessions).to eq([class_session])
    end
  end

  describe "GET show" do
		before do sign_in FactoryGirl.create :student end

    it "assigns the requested class_session as @class_session" do
      class_session = FactoryGirl.create :class_session
      get :show, {:id => class_session.to_param}, valid_session
      expect(assigns :class_session).to eq(class_session)
    end
  end

  describe "GET new" do
    it "assigns a new class_session as @class_session" do
			sign_in FactoryGirl.create :teacher
      get :new, {}, valid_session
      expect(assigns :class_session).to be_a_new(ClassSession)
    end
  end

  describe "GET edit" do
    it "assigns the requested class_session as @class_session" do
			teacher = FactoryGirl.create :teacher
			sign_in teacher
      class_session = FactoryGirl.create :class_session, teachers: [teacher]
      get :edit, {:id => class_session.to_param}, valid_session
      expect(assigns :class_session).to eq(class_session)
    end
  end

  describe "POST create" do
    before :each do
			sign_in FactoryGirl.create :teacher
		end

    describe "with valid params" do
      it "creates a new ClassSession" do
        expect {
          post :create, {:class_session => valid_attributes}, valid_session
        }.to change(ClassSession, :count).by(1)
      end

      it "assigns a newly created class_session as @class_session" do
        post :create, {:class_session => valid_attributes}, valid_session
        expect(assigns :class_session).to be_a(ClassSession)
        expect(assigns :class_session).to be_persisted
      end

      it "redirects to the created class_session" do
        post :create, {:class_session => valid_attributes}, valid_session
        expect(response).to redirect_to(ClassSession.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved class_session as @class_session" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ClassSession).to receive(:save).and_return(false)
        post :create, {:class_session => { "name" => "invalid value" }}, valid_session
        expect(assigns :class_session).to be_a_new(ClassSession)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ClassSession).to receive(:save).and_return(false)
        post :create, {:class_session => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
		let(:teacher) { FactoryGirl.create :teacher }
    let(:class_session) { FactoryGirl.create :class_session, teachers: [teacher] }

		before :each do
			sign_in teacher
		end

    describe "with valid params" do
      it "updates the requested class_session" do
        # Assuming there are no other class_sessions in the database, this
        # specifies that the ClassSession created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(ClassSession).to receive(:update).with({ "name" => "MyString" })
        put :update, {:id => class_session.to_param, :class_session => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested class_session as @class_session" do
        put :update, {:id => class_session.to_param, :class_session => valid_attributes}, valid_session
        expect(assigns :class_session).to eq(class_session)
      end

      it "redirects to the class_session" do
        put :update, {:id => class_session.to_param, :class_session => valid_attributes}, valid_session
        expect(response).to redirect_to(class_session)
      end
    end

    describe "with invalid params" do
      it "assigns the class_session as @class_session" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ClassSession).to receive(:save).and_return(false)
        put :update, {:id => class_session.to_param, :class_session => { "name" => "invalid value" }}, valid_session
        expect(assigns :class_session).to eq(class_session)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ClassSession).to receive(:save).and_return(false)
        put :update, {:id => class_session.to_param, :class_session => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
		let(:teacher) { FactoryGirl.create :teacher }
		let(:class_session) { FactoryGirl.create :class_session, teachers: [teacher] }

		before :each do
			sign_in teacher
			class_session # Make sure class session is initalized before test runs
		end

    it "destroys the requested class_session" do
      expect {
        delete :destroy, {:id => class_session.to_param}, valid_session
      }.to change(ClassSession, :count).by(-1)
    end

    it "redirects to the class_sessions list" do
      delete :destroy, {:id => class_session.to_param}, valid_session
      expect(response).to redirect_to(class_sessions_url)
    end
  end

	describe "POST subscribe" do
		let(:class_session) { FactoryGirl.create :class_session }
		let(:student) { FactoryGirl.create :student }

		before :each do
			sign_in student
		end

		subject { -> { post :subscribe, id: class_session.to_param  } }

		it { should change { class_session.subscribers.count }.by 1 }
		it { should change { class_session.subscribers.count }.by 1 }
	end

	describe "DELETE unsubscribe" do
		let(:class_session) { FactoryGirl.create :class_session }
		let(:student) { FactoryGirl.create :student }

		before :each do
			sign_in student
			class_session.subscribers << student
		end

		subject { -> { delete :unsubscribe, id: class_session.to_param  } }

		it { should change { class_session.subscribers.count }.by(-1) }
		it { should change { class_session.subscribers.count }.by(-1) }
	end
end
