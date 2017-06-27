# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EndpointAuthorization do
  describe 'authorize!' do
    let(:current_user) { OpenStruct.new(roles: roles) }

    context 'when the user has no roles' do
      let(:roles) { [] }

      it 'raises a forbidden error' do
        expect do
          described_class.authorize!('users', 'index', current_user)
        end.to raise_error(Exceptions::ForbiddenError)
      end
    end

    context 'when the user is a client admin' do
      let(:roles) { [Role.client_admin] }

      it 'returns true' do
        expect(described_class.authorize!('users', 'index', current_user)).to be_nil
      end
    end

    context 'when the endpoint is authorized by anyone' do
      let(:roles) { [] }

      it 'returns true' do
        expect(described_class.authorize!('application', 'index', current_user)).to be_nil
      end
    end
  end
end
