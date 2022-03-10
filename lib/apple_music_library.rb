# frozen_string_literal: true

require_relative "apple_music_library/library"
require_relative "apple_music_library/version"

module AppleMusicLibrary
  class Error < StandardError; end

  def self.new(music_library_file_path, verbose = false)
    AppleMusicLibrary::Library.new(music_library_file_path, verbose)
  end

end
