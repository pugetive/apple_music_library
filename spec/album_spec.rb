RSpec.describe AppleMusicLibrary::Album do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
    @album = @library.albums.first
  end

  it "stores and retrieves tracks for albums" do
    expect(@album.tracks.any?).to be true
    expect(@album.tracks.first).to be_a(AppleMusicLibrary::Track)
  end

  it "returns tracks in track order" do
    expect(@album.tracks.first.track_number).to be <= @album.tracks.last.track_number
  end

end
