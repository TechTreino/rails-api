# frozen_string_literal: true

json.exercises do
  json.partial! 'exercises/exercise', collection: @view.exercises, as: :exercise
end
