require File.expand_path("../../config/environment", __FILE__)
Dir[File.join(File.dirname(__FILE__), '..','spec/support/**/*.rb')].each do |file|
  require file
end
require 'database_cleaner'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Print the 10 slowest examples and example groups at the
  # end of the spec run.
  # config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before :each do
     DatabaseCleaner.strategy = :transaction
     DatabaseCleaner.start
  end
  config.after do
    DatabaseCleaner.clean
  end
  config.after :suite do
    File.delete('a.txt') if File.exist? 'a.txt'
    File.delete('a.scpt') if File.exist? 'a.scpt'
  end
end
