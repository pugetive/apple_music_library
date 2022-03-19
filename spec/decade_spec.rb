
RSpec.describe AppleMusicLibrary::Year do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
  end

  it 'displays track counts for a specific decade' do
    decade = @library.decades.sample
    expect(decade.track_count).to be > 0
  end

  it 'displays album counts for a specific decade' do
    decade = @library.decades.sample
    expect(decade.album_count).to be > 0
  end

  it 'displays information about the decades in the library' do
    @library.decades_report
  end

end
