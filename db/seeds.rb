# frozen_string_literal: true

ActiveRecord::Base.transaction do
  user = User.create!(email: 'default@example.com', password: '12345678', name: 'default')

  user.movies.create!([
                        {
                          description: "What's New In Ruby 3.3",
                          youtube_url: 'https://www.youtube.com/watch?v=dEZlGGKHpl4',
                        },
                        {
                          description: 'Trusted Publishing with Rubygems.org',
                          youtube_url: 'https://www.youtube.com/watch?v=g8wLthXlH4g',
                        },
                      ])
end
