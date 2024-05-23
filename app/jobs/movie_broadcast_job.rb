# frozen_string_literal: true

class MovieBroadcastJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: 3

  def perform(movie)
    ActionCable.server.broadcast 'movies_channel', {
      movie: ApplicationController.render(partial: 'movies/movie',
                                          locals: {
                                            movie:,
                                          },),
      sender: movie.user,
      description: movie.description,
    }
  end
end
