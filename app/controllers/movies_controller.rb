# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index; end

  def create
    @form = Movies::CreateForm.new(movies_create_params)

    if @form.submit
      # MovieBroadcastJob.perform_later()
      flash.now[:success] = t('.success')
    else
      flash.now[:error] = @form.errors.full_messages
    end
  end

  private

  def movies_create_params
    params.permit(:description, :youtube_url)
  end
end
