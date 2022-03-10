# frozen_string_literal: true

require_relative "lib/apple_music_library/version"

Gem::Specification.new do |spec|
  spec.name = "apple_music_library"
  spec.version = AppleMusicLibrary::VERSION
  spec.authors = ["Todd Gehman"]
  spec.email = ["github@pugetive.com"]

  spec.summary = "Provides a ruby OO interface to the information stored in an Apple Music (formerly iTunes) Library xml file."
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/pugetive/apple_music_library"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pugetive/apple_music_library"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_development_dependency "awesome_print", "~> 1.9"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21"

  spec.add_runtime_dependency "plist", "~> 3.6"
  spec.add_runtime_dependency "facets", "~> 3.1"

end
