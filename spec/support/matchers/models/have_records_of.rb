# frozen_string_literal: true

RSpec::Matchers.define :have_records_of do |expected|
  match do |query|
    query.count == expected
  end

  failure_message do |query|
    "expected query #{query} have #{expected} records but had #{query.count}"
  end
end
