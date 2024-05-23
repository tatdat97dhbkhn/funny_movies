# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Movies' do
  let(:user) { create(:user) }

  describe 'GET /movies' do
    before do
      Movie.destroy_all
      create_list(:movie, 2)
    end

    it 'returns movies' do
      sign_in user
      get movies_path

      expect(response).to have_http_status :ok

      parsed_html = Capybara::Node::Simple.new(response.body)
      expect(parsed_html).to have_css('div.list-movies')
      expect(parsed_html.has_selector?('div.movie-component', count: 2)).to be true
    end

    context 'when no authentication provided' do
      it 'returns 401' do
        get movies_path

        expect(response).to have_http_status :ok

        parsed_html = Capybara::Node::Simple.new(response.body)
        expect(parsed_html).to have_css('div.list-movies')
        expect(parsed_html.has_selector?('div.movie-component', count: 2)).to be true
      end
    end
  end

  describe 'POST /movies' do
    it 'returns movie' do
      sign_in user

      expect do
        post movies_path, params: {
          youtube_url: 'https://www.youtube.com/watch?v=2TInLtG8dj4',
          description: 'description',
        }

        expect(flash.now[:success]).to eq(I18n.t('movies.create.success'))
      end.to have_enqueued_job(MovieBroadcastJob)
             .and change(Movie, :count).by(1)
    end

    it 'fails without description' do
      sign_in user
      expect do
        post movies_path, params: {
          youtube_url: 'https://www.youtube.com/watch?v=2TInLtG8dj4',
        }
        expect(flash.now[:error]).to include("Description can't be blank")
      end.not_to change(Movie, :count)
    end

    it 'fails without youtube_url' do
      sign_in user
      expect do
        post movies_path, params: {
          description: 'description',
        }
        expect(flash.now[:error]).to include("Youtube url can't be blank")
      end.not_to change(Movie, :count)
    end

    it 'fails with wrong youtube_url' do
      sign_in user
      expect do
        post movies_path, params: {
          youtube_url: 'xxx',
          description: 'description',
        }
        expect(flash.now[:error]).to include('Youtube url is invalid')
      end.not_to change(Movie, :count)
    end

    it_behaves_like 'user-only api' do
      let(:action) do
        post movies_path, params: {
          youtube_url: 'https://www.youtube.com/watch?v=2TInLtG8dj4',
          description: 'description',
        }
      end
    end
  end
end
