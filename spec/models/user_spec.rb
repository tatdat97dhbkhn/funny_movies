# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User do
  describe 'validations' do
    it 'is invalid with blank name' do
      user = build(:user, name: nil)
      expect(user).to have_error_on :name
    end

    it 'is valid with a valid name' do
      user = build(:user, name: 'default')
      expect(user).to be_valid
    end

    it 'is valid with a valid email' do
      user = build(:user, email: 'hello@example.com')
      expect(user).to be_valid
    end

    it 'is invalid with a invalid email' do
      user = build(:user, email: '???')
      expect(user).to have_error_on :email
    end

    it 'is invalid with blank email' do
      user = build(:user, email: nil)
      expect(user).to have_error_on :email
    end

    it 'is invalid with duplicate email' do
      user = create(:user)
      new_user = build(:user, email: user.email)
      expect(new_user).to have_error_on :email
    end

    it 'is invalid with short password' do
      user = build(:user, password: 'hi')
      expect(user).to have_error_on :password
    end

    it 'is valid with appropriate password' do
      user = build(:user, password: 'a' * 16)
      expect(user).to be_valid
    end

    it 'is invalid with too short password' do
      user = build(:user, password: 'a' * 5)
      expect(user).to have_error_on :password
    end

    it 'is valid with appropriate minimum password' do
      user = build(:user, password: 'a' * 6)
      expect(user).to be_valid :password
    end

    it 'is valid with appropriate long password' do
      user = build(:user, password: 'a' * 128)
      expect(user).to be_valid :password
    end

    it 'is invalid with too long password' do
      user = build(:user, password: 'a' * 129)
      expect(user).to have_error_on :password
    end

    it 'is invalid with blank password' do
      user = build(:user, password: nil)
      expect(user).to have_error_on :password
    end
  end
end
