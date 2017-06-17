# frozen_string_literal: true

def json_response
  @json_response ||= JSON.parse(response.body).with_indifferent_access
end

def create_authenticated_customer
  customer = FactoryGirl.create(:customer)
  customer.confirm
  customer
end

def authenticate_customer
  allow(subject).to receive(:current_customer).and_return(current_customer)
end

def current_customer
  @current_customer ||= create_authenticated_customer
end
