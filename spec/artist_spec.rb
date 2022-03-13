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
    # puts "#{@artist.name} albums: #{@artist.albums.size}"
    expect(@artist.albums.any?).to be true
    expect(@artist.albums.first.year).to be <= @artist.albums.last.year
  end

  it "retrieves an artist by name" do
    artist = @library.artist('XTC')
    expect(artist).to be_a(AppleMusicLibrary::Artist)
    expect(artist.tracks.any?).to be true
  end

  it "sorts artists by most to least played" do
    expect(@library.artists(:most_played).any?).to be true
    expect(@library.artists(:most_played).first.play_count).to be > @library.artists(:most_played).last.play_count
  end

  it "sorts artists by most to least number of tracks" do
    expect(@library.artists(:most_tracks).any?).to be true
    expect(@library.artists(:most_tracks).first.track_count).to be > @library.artists(:most_tracks).last.track_count
  end

  it "sorts artists by most to least number of albums" do
    expect(@library.artists(:most_albums).any?).to be true
    expect(@library.artists(:most_albums).first.album_count).to be > @library.artists(:most_albums).last.album_count
  end

end