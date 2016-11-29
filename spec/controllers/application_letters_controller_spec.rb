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

RSpec.describe ApplicationLettersController, type: :controller do

  let(:valid_attributes) { FactoryGirl.build(:application_letter).attributes }

  let(:invalid_attributes) { FactoryGirl.build(:application_letter, event_id: nil).attributes }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ApplicationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all applications as @applications" do
      application = ApplicationLetter.create! valid_attributes
      sign_in application.user
      get :index
      expect(assigns(:application_letters)).to eq([application])
    end
  end

  describe "GET #show" do
    it "assigns the requested application as @application" do
      application = ApplicationLetter.create! valid_attributes
      sign_in application.user
      get :show, id: application.to_param
      expect(assigns(:application_letter)).to eq(application)
    end
  end

  describe "GET #new" do
    it "assigns a new application as @application" do
      sign_in FactoryGirl.create(:user)
      get :new, session: valid_session
      expect(assigns(:application_letter)).to be_a_new(ApplicationLetter)
    end
  end

  describe "GET #edit" do
    it "assigns the requested application as @application" do
      application = ApplicationLetter.create! valid_attributes
      sign_in application.user
      get :edit, id: application.to_param, session: valid_session
      expect(assigns(:application_letter)).to eq(application)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Application" do
        sign_in FactoryGirl.create(:user)
        expect {
          post :create, application_letter: valid_attributes, session: valid_session
        }.to change(ApplicationLetter, :count).by(1)
      end

      it "assigns a newly created application as @application" do
        sign_in FactoryGirl.create(:user)
        post :create, application_letter: valid_attributes, session: valid_session
        expect(assigns(:application_letter)).to be_a(ApplicationLetter)
        expect(assigns(:application_letter)).to be_persisted
      end

      it "redirects to the created application" do
        sign_in FactoryGirl.create(:user)
        post :create, application_letter: valid_attributes, session: valid_session
        expect(response).to redirect_to(ApplicationLetter.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved application as @application_letter" do
        user = FactoryGirl.create(:user)
        sign_in user
        post :create, application_letter: invalid_attributes, session: valid_session
        expect(assigns(:application_letter)).to be_a_new(ApplicationLetter)
      end

      it "re-renders the 'new' template" do
        sign_in FactoryGirl.create(:user)
        post :create, application_letter: invalid_attributes, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
            motivation: "Awesome new Motivation",
            status: true
        }
      }

      it "updates the requested application" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: new_attributes, session: valid_session
        application.reload
        expect(application.motivation).to eq(new_attributes[:motivation])
        expect(application.status).to eq(new_attributes[:status])
      end

      it "updates the requested application" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: new_attributes, session: valid_session
        application.reload
        expect(application.motivation).to eq(new_attributes[:motivation])
      end

      it "assigns the requested application as @application" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: valid_attributes, session: valid_session
        expect(assigns(:application_letter)).to eq(application)
      end

      it "redirects to the application" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: valid_attributes, session: valid_session
        expect(response).to redirect_to(application)
      end
    end

    context "with invalid params" do
      it "assigns the application as @application" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: invalid_attributes, session: valid_session
        expect(assigns(:application_letter)).to eq(application)
      end

      it "re-renders the 'edit' template" do
        application = ApplicationLetter.create! valid_attributes
        sign_in application.user
        put :update, id: application.to_param, application_letter: invalid_attributes, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested application" do
      application = ApplicationLetter.create! valid_attributes
      sign_in application.user
      expect {
        delete :destroy, id: application.to_param, session: valid_session
      }.to change(ApplicationLetter, :count).by(-1)
    end

    it "redirects to the applications list" do
      application = ApplicationLetter.create! valid_attributes
      sign_in application.user
      delete :destroy, id: application.to_param, session: valid_session
      expect(response).to redirect_to(application_letters_url)
    end
  end

end
