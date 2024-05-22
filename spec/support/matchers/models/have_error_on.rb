# frozen_string_literal: true

RSpec::Matchers.define :have_error_on do |expected|
  match do |record|
    if record.errors.empty?
      record.valid?
    end

    record.errors.key?(expected)
  end

  failure_message do |record|
    keys = record.errors.attribute_names

    "expect record.errors(#{keys}) to include #{expected}"
  end
end
