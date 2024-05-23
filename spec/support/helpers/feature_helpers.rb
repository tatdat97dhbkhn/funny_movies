# frozen_string_literal: true

module FeatureHelpers
  def sign_up_with(email, name, password, password_confirmation)
    visit new_user_registration_path
    fill_in 'user_email', with: email
    fill_in 'user_name', with: name
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_on 'Sign up'
  end

  def flash_messages
    flash = JSON.parse find_by_id('flash-messages')['data-components--flash-messages-flashes-value']
    type, messages = flash.first

    [type, messages]
  end
end
