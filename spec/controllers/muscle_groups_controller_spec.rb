# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MuscleGroupsController, type: :controller do
  describe 'index' do
    before { create_list(:muscle_group, 2) }
    before { get :index, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :muscle_groups
      expect(json_response[:muscle_groups].length).to eq 2
    end
  end
end
