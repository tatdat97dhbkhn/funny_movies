# frozen_string_literal: true

require 'spec_helper'

describe 'Sign in' do
  it 'with valid params' do
    create(:user, email: 'example@gmail.com', password: 'password')

    sign_in_with 'example@gmail.com', 'password'
    expect(page).to have_content('Logout')
  end

  it 'with blank email' do
    sign_in_with nil, 'password'
    expect(page).to have_content('Not a member?')

    type, messages = flash_messages
    expect(type).to eq('alert')
    expect(messages).to include('Invalid Email or password.')
  end

  it 'with not found email' do
    create(:user, email: 'example@gmail.com', password: '123456')

    sign_in_with 'example1@gmail.com', '123456'
    expect(page).to have_content('Not a member?')

    type, messages = flash_messages
    expect(type).to eq('alert')
    expect(messages).to include('Invalid Email or password.')
  end

  it 'with blank password' do
    sign_in_with 'example@gmail.com', nil
    expect(page).to have_content('Not a member?')

    type, messages = flash_messages
    expect(type).to eq('alert')
    expect(messages).to include('Invalid Email or password.')
  end

  it 'with password not match' do
    create(:user, email: 'example@gmail.com', password: '123456')

    sign_in_with 'example@gmail.com', '1234567'
    expect(page).to have_content('Not a member?')

    type, messages = flash_messages
    expect(type).to eq('alert')
    expect(messages).to include('Invalid Email or password.')
  end
end
