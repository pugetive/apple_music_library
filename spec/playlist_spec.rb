RSpec.describe AppleMusicLibrary::Playlist do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
    @playlist = @library.playlists.first
  end

  it "stores and retrieves tracks from playlists" do
    expect(@playlist.tracks.any?).to be true
    expect(@playlist.tracks.first).to be_a(AppleMusicLibrary::Track)
  end

  it "retrieves a playlist by name" do
    playlist = @library.playlist('XTC Favorites').first
    expect(playlist).to be_a(AppleMusicLibrary::Playlist)
    expect(playlist.tracks.any?).to be true
  end

  it "excludes folders from list of playlists" do
    @library.playlists.each do |playlist|
      expect(playlist.folder?).to be false
    end
  end


end
