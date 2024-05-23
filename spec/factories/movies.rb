# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    description { Faker::Name.name }
    youtube_url { 'https://www.youtube.com/watch?v=dEZlGGKHpl4' }

    user
  end
end
