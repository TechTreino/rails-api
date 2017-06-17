# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_paper_trail_whodunnit
  before_action :authenticate_customer!

  def index
    @view = OpenStruct.new(customers: Customer.all)
  end

  def show
    @view = OpenStruct.new(customer: Customer.find(params[:id]))
  end
end
