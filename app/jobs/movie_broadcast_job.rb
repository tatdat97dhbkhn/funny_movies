# frozen_string_literal: true

class MovieBroadcastJob < ApplicationJob
  queue_as :default

  def perform(sender, movie)
    ActionCable.server.broadcast 'movies_channel', {
      movie: ApplicationController.render(partial: 'movies/movie',
                                          locals: {
                                            movie:,
                                          },),
      sender:,
      description: movie.description,
    }
  end
end
