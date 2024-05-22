# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  description :string           not null
#  youtube_url :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_movies_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Movie < ApplicationRecord
  VALID_YOUTUBE_URL_REGEX = %r{\A((?:https?:)?//)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(/(?:[\w\-]+\?v=|embed/|v/)?)([\w\-]+)(\S+)?\z} # rubocop:disable Layout/LineLength

  belongs_to :user

  validates :description, presence: true
  validates :youtube_url, presence: true, format: { with: VALID_YOUTUBE_URL_REGEX }
end
