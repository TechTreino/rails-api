# frozen_string_literal: true

class UsersController < ApplicationController
  include Authenticable

  def index
    @view = OpenStruct.new(users: User.by_client)
  end

  def customers
    customers = User.by_client.joins(:user_roles).where(user_roles: { role_id: Role.customer.id })
    @view = OpenStruct.new(customers: customers)
  end

  def show
    @view = OpenStruct.new(user: User.by_client.find(params[:id]))
  end

  def create
    user = User.new(create_params.merge(client_id: new_user_client.id))

    if user.save
      UserMailer.welcome(user).deliver_later
      @view = OpenStruct.new(user: user)
    else
      render_validation_errors(user)
    end
  end

  private

  def new_user_client
    return Client.find(params[:user][:client_id]) if params[:user][:client_id]

    Client.find_by!(slug: params[:user][:client_slug])
  end

  def create_params
    params.require(:user).permit(%i[email password first_name last_name role_ids])
  end
end
