RSpec.describe AppleMusicLibrary::Artist do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
    @artist = @library.artists.first
  end

  it "stores and retrieves albums for artists" do
    artist = @library.artists.first
    expect(artist.albums.any?).to be true
    expect(artist.albums.first).to be_a(AppleMusicLibrary::Album)
  end

  it "orders artist albums chronologically" do
    puts "#{@artist.name} albums: #{@artist.albums.size}"
    expect(@artist.albums.any?).to be true
    expect(@artist.albums.first.year).to be <= @artist.albums.last.year
  end

  it "retrieves an artist by name" do
    artist = @library.artist('XTC')
    expect(artist).to be_a(AppleMusicLibrary::Artist)
    expect(artist.tracks.any?).to be true
  end

end