# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user] # rubocop:disable RSpec/InstanceVariable
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123', name: '123' } }
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: { email: 'invalid_email', password: 'short' } }
        end.not_to change(User, :count)
      end

      it 're-renders the new template' do
        post :create, params: { user: { email: 'invalid_email', password: 'short' } }
        expect(response).to render_template(:new)
      end
    end
  end
end
