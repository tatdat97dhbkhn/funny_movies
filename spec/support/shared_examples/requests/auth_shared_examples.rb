# frozen_string_literal: true

RSpec.shared_examples 'user-only api' do
  context 'when no authentication provided' do
    it 'sets an error flash message' do
      action
      expect(flash.now[:alert]).to include('You need to sign in or sign up before continuing.')
    end
  end
end
