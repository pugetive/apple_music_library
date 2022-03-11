RSpec.describe AppleMusicLibrary::PlaylistFolder do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
    @playlist_folders = @library.playlist_folders
  end

  it "stores and retrieves playlist folders" do
    expect(@playlist_folders.any?).to be true
    expect(@playlist_folders.first).to be_a(AppleMusicLibrary::PlaylistFolder)
  end

  it "provides access to contents (children) of folders" do
    playlist_folder = @library.playlist_folder('Folder for Testing')
    expect(playlist_folder).to be_a(AppleMusicLibrary::PlaylistFolder)
    expect(playlist_folder.children.any?).to be true
  end


  it "can contain both playlists and other playlist folders" do
    playlist_folder = @library.playlist_folder('Folder for Testing')
    expect(playlist_folder.playlist_folders.any?).to be true
    expect(playlist_folder.playlists.any?).to be true
  end

  it "displays the hierarchical structure of folders"

end
