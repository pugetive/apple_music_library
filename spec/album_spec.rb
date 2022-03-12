RSpec.describe AppleMusicLibrary::Album do

  before(:all) do
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

  it "creates an album rating based on track ratings" do
    album = @library.albums.find{|a| a.tracks.size > 1}
    expect(album.star_rating).to be_a(Integer)
    expect(album.star_rating).to be_in(1..5)
  end

end
