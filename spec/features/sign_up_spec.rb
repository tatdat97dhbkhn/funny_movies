# frozen_string_literal: true

require 'spec_helper'

describe 'Sign up' do
  it 'with valid params' do
    expect do
      sign_up_with 'example@gmail.com', 'name', 'password', 'password'
      expect(page).to have_content('Logout')
    end.to change(User, :count).by(1)
  end

  it 'with blank email' do
    expect do
      sign_up_with nil, 'name', 'password', 'password'
      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include("Email can't be blank")
    end.not_to change(User, :count)
  end

  it 'with invalid email' do
    expect do
      sign_up_with 'invalid_email', 'name', 'password', 'password'

      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include('Email is invalid')
    end.not_to change(User, :count)
  end

  it 'with blank password' do
    expect do
      sign_up_with 'example@gmail.com', 'name', '', 'password'
      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include("Password can't be blank")
    end.not_to change(User, :count)
  end

  it 'with too short password' do
    expect do
      sign_up_with 'example@gmail.com', 'name', '1', '1'
      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include('Password is too short (minimum is 6 characters)')
    end.not_to change(User, :count)
  end

  it 'with too long password' do
    expect do
      sign_up_with 'example@gmail.com', 'name', 'a' * 129, 'a' * 129
      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include('Password is too long (maximum is 128 characters)')
    end.not_to change(User, :count)
  end

  it 'with password and password_confirmation does not match' do
    expect do
      sign_up_with 'example@gmail.com', 'name', '123456', '1234567'
      expect(page).to have_content('Do have an account ?')

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include("Password confirmation doesn't match Password")
    end.not_to change(User, :count)
  end

  it 'with invalid avatar content type', :js do
    expect do
      visit new_user_registration_path

      attach_file(Rails.root.join('spec/fixtures/files/videos/example.mp4').to_s) do
        click_on 'Select New Avatar'
      end

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include('File has an invalid content type')
    end.not_to change(User, :count)
  end

  it 'with valid avatar' do
    expect do
      visit new_user_registration_path

      attach_file(Rails.root.join('spec/fixtures/files/images/example.jpg').to_s) do
        click_on 'Select New Avatar'
      end

      sign_up_with 'example@gmail.com', 'name', 'password', 'password'
      expect(page).to have_content('Logout')
    end.to change(User, :count).by(1)
  end
end
