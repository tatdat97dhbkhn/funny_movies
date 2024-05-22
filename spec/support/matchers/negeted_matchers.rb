# frozen_string_literal: true

RSpec::Matchers.define_negated_matcher :not_change, :change
RSpec::Matchers.define_negated_matcher :have_enqueued_no_job, :enqueue_sidekiq_job
RSpec::Matchers.define_negated_matcher :not_include, :include
