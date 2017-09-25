require "bundler/setup"
require "bases_loaded"
require 'rails'
require 'active_record'

spec_dir = File.dirname(File.expand_path(__FILE__))
database_yml_path = File.join(spec_dir, 'database.yml')
ActiveRecord::Base.configurations = YAML.load_file(database_yml_path)
Rails.env = 'test'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
