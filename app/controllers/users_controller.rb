# frozen_string_literal: true

class UsersController < ApplicationController
  include Authenticable
  before_action :set_paper_trail_whodunnit

  def index
    @view = OpenStruct.new(users: User.by_client.all)
  end

  def show
    @view = OpenStruct.new(user: User.by_client.find(params[:id]))
  end

  def create
    user = User.new(create_params)
    user.client = new_user_client
    user.save!
    UserMailer.welcome(user).deliver_later

    @view = OpenStruct.new(user: user)
  end

  def new_user_client
    Client.find(params[:user][:client_id]) if params[:user][:client_id]
    Client.find_by!(slug: params[:user][:client_slug]) if params[:user][:client_slug]
  end

  def create_params
    params.require(:user).permit(%i[email password first_name last_name roles])
  end
end
