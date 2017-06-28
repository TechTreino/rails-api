# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ExercisesController, type: :controller do
  describe 'index' do
    before { create_list(:exercise, 2, client: current_user.client) }
    before { get :index, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :exercises
      expect(json_response[:exercises].length).to eq 2
    end

    it "only returns exercises scoped to current user's client_id" do
      create(:exercise)
      expect(json_response).to have_key :exercises
      expect(json_response[:exercises].length).to eq 2
    end
  end

  describe 'show' do
    let!(:exercises) { create_list(:exercise, 2, client: current_user.client) }
    let!(:exercise_id) { exercises.first.id }
    let!(:params) { { id: exercise_id } }

    before { authenticate_user }
    before { get :show, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the data' do
      expect(json_response).to have_key :exercise
      expect(json_response[:exercise][:id]).to eq(exercise_id)
    end
  end

  describe 'create' do
    let!(:params) { { exercise: { name: 'Supino', muscle_group_id: create(:muscle_group).id } } }

    before { authenticate_user }
    before { post :create, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'creates the exercise' do
      expect(json_response).to have_key :exercise
      expect(Exercise.count).to eq(1)
      expect(json_response[:exercise][:id]).to eq(Exercise.first.id)
    end

    context 'when there are validation errors' do
      let(:params) { { exercise: { muscle_group_id: '-42' } } }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the errors' do
        expect(json_response).to have_key :errors
        expect(json_response[:errors]).to have_key :name
      end
    end
  end

  describe 'update' do
    let!(:exercise) { create(:exercise, name: 'something', client: current_user.client) }
    let!(:muscle_group_id) { create(:muscle_group).id }
    let!(:params) { { id: exercise.id, exercise: { name: 'Supino', muscle_group_id: muscle_group_id } } }

    before { authenticate_user }
    before { post :update, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'updates the exercise' do
      expect(json_response).to have_key :exercise
      expect(json_response[:exercise][:name]).to eq('Supino')
      expect(json_response[:exercise][:muscle_group_id]).to eq(muscle_group_id)
      expect(Exercise.count).to eq(1)
      expect(Exercise.first.name).to eq('Supino')
    end

    context 'when there are validation errors' do
      let(:params) { { id: exercise.id, exercise: { muscle_group_id: '-42' } } }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the errors' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to have_key :errors
        expect(json_response[:errors]).to have_key :muscle_group
      end
    end
  end

  describe 'destroy' do
    let!(:exercise) { create(:exercise, name: 'something', client: current_user.client) }
    let!(:muscle_group_id) { create(:muscle_group).id }
    let!(:params) { { id: exercise.id } }

    before { authenticate_user }
    before { delete :destroy, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'deletes the exercise' do
      expect(Exercise.count).to eq(0)
    end
  end
end
