# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!

  def index
    @view = OpenStruct.new(users: User.by_client.all)
  end

  def show
    @view = OpenStruct.new(user: User.by_client.find(params[:id]))
  end
end
