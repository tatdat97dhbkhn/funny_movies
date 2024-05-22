# frozen_string_literal: true

class MovieBroadcastJob < ApplicationJob
  queue_as :default

  def perform(**options); end
end
