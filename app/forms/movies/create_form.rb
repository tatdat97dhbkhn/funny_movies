# frozen_string_literal: true

module Movies
  class CreateForm < ApplicationForm
    attr_accessor :description, :youtube_url

    validates :description, presence: true
    validates :youtube_url, presence: true

    def submit
      assign_attributes(description:, youtube_url:)

      valid?
    end
  end
end
