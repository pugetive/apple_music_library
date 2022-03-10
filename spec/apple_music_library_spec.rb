# frozen_string_literal: true

VERBOSE = false
VALID_LIBRARY_PATH = './spec/Library.valid.xml'
INVALID_LIBRARY_PATH = './spec/Library.invalid.xml'

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

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
  end

  it "loads and parses the XML file" do
    expect(@library.valid?).to be true
  end

  it "creates track objects from the library" do
    expect(@library.tracks.any?).to be true
    expect(@library.tracks.first).to be_a(AppleMusicLibrary::Track)
  end

  it "creates artist objects from the library" do
    expect(@library.artists.any?).to be true
    expect(@library.artists.first).to be_a(AppleMusicLibrary::Artist)
  end

  it "creates playlist objects from the library" do
    expect(@library.playlists.any?).to be true
    expect(@library.playlists.first).to be_a(AppleMusicLibrary::Playlist)
  end

  it "creates album objects from the library" do
    expect(@library.albums.any?).to be true
    expect(@library.albums.first).to be_a(AppleMusicLibrary::Album)
  end
  
end
