# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MovieBroadcastJob do
  let(:movie) { create(:movie) }

  describe '#perform' do
    it 'retries 3 times' do
      expect(described_class).to be_retryable 3
    end

    it 'broadcasts the movie details' do
      expect do
        described_class.perform_now(movie)
      end.to have_broadcasted_to('movies_channel')
    end

    it 'fails if movie is nil' do
      expect do
        described_class.perform_now
      end.to raise_error ArgumentError
    end
  end
end
