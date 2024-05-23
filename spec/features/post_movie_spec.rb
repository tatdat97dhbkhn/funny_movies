# frozen_string_literal: true

require 'spec_helper'

describe 'Post movie' do
  let(:user) { create(:user, email: 'example@gmail.com', password: '123456') }
  let(:youtube_url) { 'https://www.youtube.com/watch?v=dEZlGGKHpl4' }

  before do
    Movie.destroy_all
    create_list(:movie, 2, user:)

    sign_in_with 'example@gmail.com', '123456'
  end

  it 'with valid params', :js do
    expect do
      post_movie_with 'demo', youtube_url

      sleep 5

      type, messages = flash_messages
      expect(type).to eq('success')
      expect(messages).to include(I18n.t('movies.create.success'))
    end.to have_enqueued_job(MovieBroadcastJob)
             .and change(Movie, :count).by(1)
  end

  it 'with blank description', :js do
    expect do
      post_movie_with nil, youtube_url

      sleep 5

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include("Description can't be blank")
    end.not_to change(Movie, :count)
  end

  it 'with blank youtube_url', :js do
    expect do
      post_movie_with 'demo', nil

      sleep 5

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include("Youtube url can't be blank")
    end.not_to change(Movie, :count)
  end

  it 'with invalid youtube_url', :js do
    expect do
      post_movie_with 'demo', 'invalid_url'

      sleep 5

      type, messages = flash_messages
      expect(type).to eq('error')
      expect(messages).to include('Youtube url is invalid')
    end.not_to change(Movie, :count)
  end
end
