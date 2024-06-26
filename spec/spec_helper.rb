# frozen_string_literal: true

# Coverage
require 'simplecov'
require 'simplecov-cobertura'
require 'simplecov-html'
require 'capybara/rspec'

SimpleCov.start 'rails' do
  enable_coverage :branch
  primary_coverage :branch

  formatter SimpleCov::Formatter::MultiFormatter.new([
                                                       SimpleCov::Formatter::HTMLFormatter,
                                                       SimpleCov::Formatter::CoberturaFormatter,
                                                     ])

  add_filter '/app/channels/'
  add_filter '/app/mailers/'

  add_group 'Services', 'app/services'
end

# Rails environment setup
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

# Libraries
require 'rspec/rails'
require 'webmock/rspec'
require 'super_diff'
require 'super_diff/rspec'
require 'super_diff/active_support'
require 'capybara/rails'
require 'selenium/webdriver'

# have to be required after `rspec-sidekiq` in order to avoid overwriting `enqueue_sidekiq_job` matcher
require 'rspec/enqueue_sidekiq_job'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app,
                                 browser: :remote,
                                 url: ENV.fetch('SELENIUM_DRIVER_URL', nil),
                                 options:,)
end
Capybara.javascript_driver = :chrome
Capybara.always_include_port = true

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each, type: :feature) do |example|
    if example.metadata[:js]
      WebMock.allow_net_connect!
      Capybara.ignore_hidden_elements = false
      Capybara.current_driver = :chrome

      Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:#{ENV.fetch('CAPYBARA_SERVER_PORT', nil)}"
      Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
      Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', nil)
    else
      Capybara.current_driver = :rack_test
    end
  end

  config.before(:each, type: :request) do
    Capybara.current_driver = :rack_test
  end

  config.before do
    ActiveStorage::Current.url_options = { host: 'https://example.com' }
  end

  config.define_derived_metadata do |metadata|
    metadata[:stub_batches] = true
  end

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = 'tmp/spec_examples.txt'

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # rails-rspec
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # arbitrary gems may also be filtered via:
  config.filter_gems_from_backtrace(
    'factory_bot',
    'rack',
    'railties',
    'super_diff',
    'warden',
    'webmock',
  )

  config.before(:suite) do
    FactoryBot::SyntaxRunner.include RSpec::Mocks::ExampleMethods
  end

  # Helpers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods
  config.include ModelHelpers
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include FeatureHelpers
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end
