require 'simplecov'
SimpleCov.start

# frozen_string_literal: true

require "apple_music_library"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # config.failure_color = :magenta
  # config.tty = true
  # config.color = true

end


