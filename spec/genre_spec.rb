RSpec.describe AppleMusicLibrary::Genre do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
  end

  it "stores and retrieves tracks for genres" do
    genre = @library.genres.first
    expect(genre.tracks.any?).to be true
    expect(genre.tracks.first).to be_a(AppleMusicLibrary::Track)
    expect(genre.tracks.first.genre_name).to be genre.name
  end

  it "retrieves a genre by name" do
    genre = @library.genre('General Rock')
    expect(genre).to be_a(AppleMusicLibrary::Genre)
    expect(genre.tracks.any?).to be true
  end


end


