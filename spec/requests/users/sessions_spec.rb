# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Users::Sessions' do
  describe 'GET /users/sign_in' do
    it 'returns sign_in template' do
      get new_user_session_path

      expect(response).to have_http_status :ok

      parsed_html = Capybara::Node::Simple.new(response.body)
      expect(parsed_html).to have_css('div.devise-layout')
    end
  end
end
