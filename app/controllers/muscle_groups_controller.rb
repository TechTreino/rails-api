# frozen_string_literal: true

class MuscleGroupsController < ApplicationController
  include Authenticable

  def index
    @view = OpenStruct.new(muscle_groups: MuscleGroup.all)
  end
end
