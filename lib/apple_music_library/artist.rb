module AppleMusicLibrary
  class Artist

    attr_reader :name

    @@artists = {}

    def initialize(name)
      @name = name
      @albums = []
      @tracks = []
    end

    def self.all
      @@artists.values
    end

    def self.most_played(limit = 20)
      if limit.nil?
        self.all.sort_by(&:play_count).reverse
      else
        self.all.sort_by(&:play_count).reverse.take(limit)
      end
    end

    def self.find_or_create(name)
      if @@artists[name]
        return @@artists[name]
      end
      @@artists[name] = self.new(name)
    end

    def self.find_by_name(artist_name)
      if @@artists[artist_name]
        return @@artists[artist_name]
      end
      nil
    end

    def add_album(album)
      unless @albums.include?(album)
        @albums << album
      end
    end

    def add_track(track)
      unless @tracks.include?(track)
        @tracks << track
      end
    end

    def albums
      @albums.sort_by(&:year)
    end

    def tracks
      @tracks
    end

    def play_count
      tracks.map(&:play_count).sum
    end

  end
end
