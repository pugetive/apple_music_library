module AppleMusicLibrary
  class Album
    attr_reader :artist


    attr_reader :artist, :album_name, :tracks

    @@albums = {}

    def initialize(artist, album_name)
      @artist = artist
      @album_name = album_name
      @tracks = []
    end

    def self.all
      @@albums.values
    end

    def self.find_or_create(artist, album_name)
      key = "#{artist.name}-#{album_name}"
      if @@albums[key]
        return @@albums[key]
      end
      @@albums[key] = self.new(artist, album_name)
    end

    def id
      "#{artist.name}-#{album_name}"
    end

    def add_track(track)
      @tracks << track
    end

    def year
      @year ||= @tracks.sort_by(&:year).last.year
    end

  end
end
