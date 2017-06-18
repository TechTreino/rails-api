# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    client = Client.find(params[:client_id])

    super do |resource|
      resource.update(params.permit(:first_name, :last_name, client: client))
    end
  end
end
