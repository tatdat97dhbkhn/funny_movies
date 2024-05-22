# frozen_string_literal: true

module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.replace 'flash-messages', partial: 'shared/flash_messages'
  end

  def get_youtube_video_id(url)
    regex = %r{(?:https?://)?(?:www\.)?(?:youtube\.com/(?:[^/\n\s]+/\S+/|(?:v|e(?:mbed)?)/|\S*?[?&]v=)|youtu\.be/)([a-zA-Z0-9_-]{11})} # rubocop:disable Layout/LineLength
    match = url.match(regex)
    match ? match[1] : nil
  end
end
