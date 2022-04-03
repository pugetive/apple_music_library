RSpec.describe AppleMusicLibrary::Year do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
  end

  it 'displays track counts for a specific century' do
    century = @library.centuries.sample
    expect(century.track_count).to be > 0
  end

  it 'displays album counts for a specific century' do
    century = @library.centuries.sample
    expect(century.album_count).to be > 0
  end

  it 'displays information about the centuries in the library' do
    @library.centuries_report
  end

end
