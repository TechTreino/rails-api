# frozen_string_literal: true

module ControllerSpecHelper
  def json_response
    @json_response ||= JSON.parse(response.body).with_indifferent_access
  end

  def create_authenticated_user
    user = FactoryGirl.create(:user)
    user.confirm
    user
  end

  def authenticate_user
    allow(subject).to receive(:current_user).and_return(current_user)
  end

  def current_user
    @current_user ||= create_authenticated_user
  end
end
