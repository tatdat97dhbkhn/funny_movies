# frozen_string_literal: true

module RequestSpecHelpers
  extend ActiveSupport::Concern

  JSON_HEADERS = { 'Accept' => 'application/json' }.freeze

  def json
    JSON.parse(response.body)
  end

  # https://ver-1-0.net/2019/10/06/request-spec-set-header-every-request
  %i[get post patch delete head].each do |name|
    define_method(name) do |path, params: {}, headers: {}, env: nil, xhr: false, as: nil|
      if name == :get
        raise ArgumentError, 'GET request cannot have body. pass `params` to path method instead' unless params.empty?
      else
        as = :json unless env&.[]('Content-Type') == 'multipart/form-data'
      end
      # call of defined? inside ternary operator causes false positives
      defaults = (defined? default_headers) ? default_headers : {} # rubocop:disable Style:TernaryParentheses
      super(path, params:, headers: JSON_HEADERS.merge(defaults).merge(headers),
                  env:, xhr:, as:)
    end
  end

  def put(...)
    raise NotImplementedError, 'use `patch` for updating resources'
  end
end
