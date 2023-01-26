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
    playlist = @library.playlist('XTC Favorites')
    expect(playlist).to be_a(AppleMusicLibrary::Playlist)
    expect(playlist.tracks.any?).to be true
  end

  it "excludes folders from list of playlists" do
    @library.playlists.each do |playlist|
      expect(playlist.folder?).to be false
    end
  end

  it "distinguishes between smart playlists and regular playlists" do
    @library.playlists(:smart).each do |playlist|
      expect(playlist.smart?).to be true
    end

    @library.playlists(:regular).each do |playlist|
      expect(playlist.smart?).to be false
    end
  end

  it "distinguishes between Apple-created (system) playlists and regular playlists" do
    @library.playlists(:regular).each do |playlist|
      expect(playlist.system?).to be false
    end

    @library.playlists(:system).each do |playlist|
      expect(playlist.system?).to be true
    end
  end

  # it "associates each track with its album" do
  #   raise @library.playlists.first.inspect
  #   # @library.playlists.first.tracks.each do |track|
  #   #   expect(track.album).to be_a(AppleMusicLibrary::Album)
  #   #   expect(track.album.name).to match(/\w+/)
  #   # end
  # end

end
