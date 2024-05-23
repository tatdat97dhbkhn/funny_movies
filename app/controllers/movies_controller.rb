# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    @movies = Movie.order(created_at: :desc)
  end

  def create
    movie = current_user.movies.new(movies_params)
    if movie.save
      MovieBroadcastJob.perform_later(movie)
      flash.now[:success] = t('.success')
    else
      flash.now[:error] = movie.errors.full_messages
    end
  end

  private

  def movies_params
    params.permit(:description, :youtube_url)
  end
end
