# frozen_string_literal: true

class RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    super do |resource|
      resource.update(params.permit(:first_name, :last_name))
    end
  end
end
