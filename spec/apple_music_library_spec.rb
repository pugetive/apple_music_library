# frozen_string_literal: true

VERBOSE = false
RSPEC_ROOT = File.dirname __FILE__
VALID_LIBRARY_PATH = "#{RSPEC_ROOT}/Library.valid.xml"
INVALID_LIBRARY_PATH = "#{RSPEC_ROOT}/Library.invalid.xml"

RSpec.describe AppleMusicLibrary do
  it "has a version number" do
    expect(AppleMusicLibrary::VERSION).not_to be nil
  end


  it "requires a valid path to a valid library file" do
    expect {AppleMusicLibrary.new}.to raise_error(ArgumentError)
    expect {AppleMusicLibrary.new('nonexistent_path')}.to raise_error(AppleMusicLibrary::Error)
    expect {AppleMusicLibrary.new(VALID_LIBRARY_PATH)}.not_to raise_error
  end

  it "raises error with invalid plist file" do
    expect { AppleMusicLibrary.new(INVALID_LIBRARY_PATH) }.to raise_error(AppleMusicLibrary::Error)
  end
  
end
