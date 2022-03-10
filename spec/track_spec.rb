require 'facets'

RSpec.describe AppleMusicLibrary::Track do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
    @sample_track = @library.tracks.sample
  end

  it 'provides ruby methods for all standard attributes' do
    AppleMusicLibrary::Track::ATTRIBUTES.each do |attribute|
      expect(@sample_track.respond_to?(attribute.snakecase)).to be true
    end
  end

  it 'overrides artist, genre, album attributes to return objects instead' do
    expect(@sample_track.artist).to be_a(AppleMusicLibrary::Artist)
    expect(@sample_track.genre).to be_a(AppleMusicLibrary::Genre)
    expect(@sample_track.album).to be_a(AppleMusicLibrary::Album)
  end

  it 'references a fully-relized artist object through #artist' do
    expect(@sample_track.artist.tracks.count).to be > 0
  end

  it 'references a fully-relized genre object through #genre' do
    expect(@sample_track.genre.tracks.count).to be > 0
  end

  it 'references a fully-relized album object through #album' do
    expect(@sample_track.album.tracks.count).to be > 0
  end

end
