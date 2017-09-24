ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'simplecov'
require 'database_cleaner'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'factory_girl_rails'

SimpleCov.start 'rails'
SimpleCov.minimum_coverage 90
SimpleCov.maximum_coverage_drop 0

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.order = :random

  config.include FactoryGirl::Syntax::Methods

  Capybara.register_driver :poltergeist do |app|
    options = {
      js_errors: false,
      window_size: [2048, 1024],
      timeout: 120,
      debug: false,
      inspector: true
    }
    Capybara::Poltergeist::Driver.new(app, options)
  end

  Capybara.javascript_driver = :poltergeist
  Capybara::Screenshot.autosave_on_failure = true

  Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
    "screenshot_#{example.description.tr(' ', '-').gsub(%r{^.*\/spec\/}, '')}"
  end
  Capybara::Screenshot.append_timestamp = true
  Capybara.default_max_wait_time = 10

  config.include Rails.application.routes.url_helpers
end
