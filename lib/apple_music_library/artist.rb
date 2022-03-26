module AppleMusicLibrary
  class Artist

    attr_reader :name

    @@artists = {}

    def initialize(name)
      @name = name.strip
      @albums = []
      @tracks = []
    end

    def self.all
      @@artists.values
    end

    def self.most_played(limit = 20)
      self.sorted_set(:play_count, limit)
    end

    def self.most_tracks(limit = 20)
      self.sorted_set(:track_count, limit)
    end

    def self.most_albums(limit = 20)
      self.sorted_set(:album_count, limit)
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

    def album_count
      @albums.size
    end

    def tracks
      @tracks
    end

    def track_count
      @tracks.size
    end

    def play_count
      tracks.map(&:play_count).sum
    end

    def genres
      @genres ||= tracks.map(&:genre).uniq
    end

    protected

    def self.sorted_set(sort_by_method, limit)
      if limit.nil?
        self.all.sort_by{|a| a.send(sort_by_method)}.reverse
      else
        self.all.sort_by{|a| a.send(sort_by_method)}.reverse.take(limit)
      end
    end
  end
end
