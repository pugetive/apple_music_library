module AppleMusicLibrary
  class Album
    attr_reader :artist


    attr_reader :artist, :album_name, :tracks

    def initialize(artist, album_name)
      @artist = artist
      @album_name = album_name
      @tracks = []
    end

    def id
      "#{artist.name}-#{album_name}"
    end

    def add_track(track)
      @tracks << track
    end

    def year
      @year ||= tracks.sort(&:year).last.year
    end

  end
end
