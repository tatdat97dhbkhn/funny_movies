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

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_on 'Sign in'
  end

  def post_movie_with(description, youtube_url)
    fill_in 'description', with: description
    fill_in 'youtube_url', with: youtube_url
    click_on 'Post'
  end

  def flash_messages
    flash = JSON.parse find('div#flash-messages', visible: false)['data-components--flash-messages-flashes-value']
    type, messages = flash.first

    [type, messages]
  end
end
