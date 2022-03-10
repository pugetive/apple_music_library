VERBOSE = false

RSpec.describe AppleMusicLibrary::Library do
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
