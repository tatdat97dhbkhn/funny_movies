# frozen_string_literal: true

class MoviesChannel < ApplicationCable::Channel
  def subscribed
    stream_from('movies_channel')
  end

  def unsubscribed
    stop_stream_from('movies_channel')
  end
end
