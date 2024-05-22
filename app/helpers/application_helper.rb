# frozen_string_literal: true

module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.replace 'flash-messages', partial: 'shared/flash_messages'
  end
end
