require 'rails_helper'

RSpec.describe ContratantesController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #cpf" do
    it "returns http success" do
      get :cpf
      expect(response).to have_http_status(:success)
    end
  end

end