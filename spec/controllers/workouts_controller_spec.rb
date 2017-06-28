# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe WorkoutsController, type: :controller do
  describe 'index' do
    before { create_list(:workout, 2, client: current_user.client, user: current_user) }
    before { get :index, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the data' do
      expect(json_response).to have_key :workouts
      expect(json_response[:workouts].length).to eq 2
    end

    it "only returns workouts scoped to current user's client_id" do
      create(:workout)
      expect(json_response).to have_key :workouts
      expect(json_response[:workouts].length).to eq 2
    end
  end

  describe 'show' do
    let!(:workouts) { create_list(:workout, 2, client: current_user.client, user: current_user) }
    let!(:workout_id) { workouts.first.id }
    let!(:params) { { id: workout_id } }

    before { get :show, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the data' do
      expect(json_response).to have_key :workout
      expect(json_response[:workout][:id]).to eq(workout_id)
    end
  end

  describe 'create' do
    let!(:exercise_id) { create(:exercise, client: current_user.client).id }
    let!(:first_workout_exercise) { { sets: 1, repetitions: 10, exercise_id: exercise_id } }
    let!(:second_workout_exercise) { { sets: 3, repetitions: 8, exercise_id: exercise_id } }
    let!(:params) do
      {
        workout: {
          name: 'AB',
          user_id: current_user.id,
          workout_exercises: [first_workout_exercise, second_workout_exercise]
        }
      }
    end

    before { post :create, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'creates the workout' do
      expect(json_response).to have_key :workout
      expect(Workout.count).to eq(1)
      expect(json_response[:workout][:id]).to eq(Workout.first.id)
      expect(json_response[:workout]).to have_key 'workoutExercises'
      expect(json_response[:workout]['workoutExercises'].length).to eq(2)
    end
  end

  describe 'update' do
    let!(:workout) { create(:workout, name: 'work', user: current_user, client: current_user.client) }
    let!(:user) { create(:user) }
    let!(:exercise_id) { create(:exercise, client: current_user.client).id }
    let!(:first_workout_exercise) { { sets: 1, repetitions: 10, exercise_id: exercise_id } }
    let!(:second_workout_exercise) { { sets: 3, repetitions: 8, exercise_id: exercise_id } }
    let!(:params) do
      {
        id: workout.id,
        workout: {
          name: 'AB',
          user_id: user.id,
          workout_exercises: [first_workout_exercise, second_workout_exercise]
        }
      }
    end

    before { put :update, params: params, format: :json }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'updates the workout' do
      expect(json_response).to have_key :workout
      expect(Workout.count).to eq(1)
      expect(json_response[:workout][:id]).to eq(workout.id)
      expect(json_response[:workout][:name]).to eq('AB')
      expect(json_response[:workout]['userId']).to eq(user.id)
      expect(json_response[:workout]).to have_key 'workoutExercises'
      expect(json_response[:workout]['workoutExercises'].length).to eq(2)
    end

    describe 'updating available workout exercises' do
      let!(:new_exercise_id) { create(:exercise).id }
      let!(:first_workout_exercise) do
        id = create(:workout_exercise, sets: 1, repetitions: 10, exercise_id: exercise_id, workout: workout).id
        { id: id, sets: 2, repetitions: 12, exercise_id: new_exercise_id }
      end
      let!(:second_workout_exercise) do
        id = create(:workout_exercise, sets: 2, repetitions: 11, exercise_id: exercise_id, workout: workout).id
        { id: id, sets: 3, repetitions: 9, exercise_id: new_exercise_id }
      end

      it "updates the workout's workout_exercises" do
        expect(json_response).to have_key :workout
        expect(Workout.count).to eq(1)
        expect(WorkoutExercise.count).to eq(2)
        expect(json_response[:workout][:id]).to eq(workout.id)
        expect(json_response[:workout]).to have_key 'workoutExercises'
        expect(json_response[:workout]['workoutExercises'].length).to eq(2)
        expect(json_response[:workout]['workoutExercises'][0][:sets]).to eq(2)
        expect(json_response[:workout]['workoutExercises'][0][:repetitions]).to eq(12)
        expect(json_response[:workout]['workoutExercises'][1][:sets]).to eq(3)
        expect(json_response[:workout]['workoutExercises'][1][:repetitions]).to eq(9)
      end
    end
  end

  describe 'delete' do
    let!(:workout) { create(:workout, client: current_user.client, user: current_user) }
    let!(:params) { { id: workout.id } }

    before { delete :destroy, params: params, format: :json }

    it 'returns no_content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the workout' do
      expect(Workout.count).to eq(0)
    end
  end
end
