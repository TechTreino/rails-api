# frozen_string_literal: true

json.muscle_groups do
  json.partial! 'muscle_groups/muscle_group', collection: @view.muscle_groups, as: :muscle_group
end
