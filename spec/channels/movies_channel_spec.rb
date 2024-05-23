# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MoviesChannel do
  before do
    # Simulate a subscription
    stub_connection
  end

  describe '#subscribed' do
    it 'subscribes to a stream' do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from('movies_channel')
    end
  end

  describe '#unsubscribed' do
    it 'unsubscribes from a stream' do
      subscribe
      expect(subscription).to have_stream_from('movies_channel')
      subscription.unsubscribe_from_channel
      expect(subscription).not_to have_streams
    end
  end
end
