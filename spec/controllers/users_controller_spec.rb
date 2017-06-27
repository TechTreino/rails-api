# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe UsersController, type: :controller do
  describe 'index' do
    before { create_list(:user, 2, client: current_user.client) }
    before { get :index, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :users
      expect(json_response[:users].length).to eq 3
    end

    it "only returns users scoped to current user's client_id" do
      create(:user)
      expect(json_response).to have_key :users
      expect(json_response[:users].length).to eq 3
    end
  end

  describe 'customers' do
    before { create_list(:user, 2, client: current_user.client) { |user| user.roles = [Role.customer] } }
    before { get :customers, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :users
      expect(json_response[:users].length).to eq 2
    end

    it "only returns customers scoped to current user's client_id" do
      create(:user)
      expect(json_response).to have_key :users
      expect(json_response[:users].length).to eq 2
    end
  end

  describe 'show' do
    let!(:users) { create_list(:user, 2, client: current_user.client) }
    let!(:user_id) { users.first.id }
    let!(:params) { { id: user_id } }

    before { authenticate_user }
    before { get :show, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the data' do
      expect(json_response).to have_key :user
      expect(json_response[:user][:id]).to eq(user_id)
    end
  end
end
