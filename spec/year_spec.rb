
RSpec.describe AppleMusicLibrary::Year do

  before do
    @library = AppleMusicLibrary.new(VALID_LIBRARY_PATH, VERBOSE)
  end

  it 'displays all tracks released in a specific year' do
    year = @library.years.sample
    expect(year.name).to be_a(Integer)
    expect(year.track_count).to be > 0
  end

end
