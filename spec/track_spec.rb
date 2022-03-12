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

  it 'can check if a track has been rated' do
    expect(@sample_track.rated?).to be_in([true, false])
  end

  it 'can display ratings as stored 100-point number or as star ratings' do
    expect(@sample_track.rating).to be_a(Integer)
    expect(@sample_track.rating).to be <= 100
    expect(@sample_track.rating % 20).to be 0
    expect(@sample_track.star_rating).to be_a(Integer)
    expect(@sample_track.star_rating).to be <= 5
  end

  it 'can filter for tracks that have been "loved"' do
    expect(@library.tracks(:loved).any?).to be true
    expect(@library.tracks(:loved).sample.loved?).to be true
  end

end
