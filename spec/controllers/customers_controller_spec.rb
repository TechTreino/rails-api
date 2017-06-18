# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe CustomersController, type: :controller do
  describe 'index' do
    before { create_list(:customer, 2, client: current_customer.client) }
    before { get :index, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :customers
      expect(json_response[:customers].length).to eq 3
    end

    it "only returns customers scoped to current customer's client_id" do
      create(:customer)
      expect(json_response).to have_key :customers
      expect(json_response[:customers].length).to eq 3
    end
  end

  describe 'show' do
    let!(:customers) { create_list(:customer, 2, client: current_customer.client) }
    let!(:customer_id) { customers.first.id }
    let!(:params) { { id: customer_id } }

    before { authenticate_customer }
    before { get :show, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the data' do
      expect(json_response).to have_key :customer
      expect(json_response[:customer][:id]).to eq(customer_id)
    end
  end
end
