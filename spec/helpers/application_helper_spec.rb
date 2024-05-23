# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ApplicationHelper do
  describe '#get_youtube_video_id' do
    it 'returns the video ID for a valid YouTube URL' do
      url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
      expect(helper.get_youtube_video_id(url)).to eq('dQw4w9WgXcQ')
    end

    it 'returns the video ID for a valid shortened YouTube URL' do
      url = 'https://youtu.be/dQw4w9WgXcQ'
      expect(helper.get_youtube_video_id(url)).to eq('dQw4w9WgXcQ')
    end

    it 'returns nil for an invalid YouTube URL' do
      url = 'https://www.example.com/watch?v=dQw4w9WgXcQ'
      expect(helper.get_youtube_video_id(url)).to be_nil
    end

    it 'returns nil for a YouTube URL with an invalid video ID' do
      url = 'https://www.youtube.com/watch?v=invalid_id'
      expect(helper.get_youtube_video_id(url)).to be_nil
    end
  end
end
