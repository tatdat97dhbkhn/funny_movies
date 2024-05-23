# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Movie do
  describe 'validations' do
    it 'is invalid with blank description' do
      movie = build(:movie, description: nil)
      expect(movie).to have_error_on :description
    end

    it 'is valid with a valid description' do
      movie = build(:movie, description: 'default')
      expect(movie).to be_valid
    end

    it 'is valid with a valid youtube_url' do
      movie = build(:movie, youtube_url: 'https://www.youtube.com/watch?v=eEQoeKGCQ4c&t=4293s')
      expect(movie).to be_valid

      movie2 = build(:movie, youtube_url: 'https://youtu.be/eEQoeKGCQ4c?si=m_2tJjlUI5_Jpsnw')
      expect(movie2).to be_valid
    end

    it 'is invalid with a invalid youtube_url' do
      movie = build(:movie, youtube_url: '???')
      expect(movie).to have_error_on :youtube_url
    end

    it 'is invalid with blank email' do
      movie = build(:movie, youtube_url: nil)
      expect(movie).to have_error_on :youtube_url
    end
  end
end
