module AppleMusicLibrary
  class TrackCollection

    attr_reader :name, :tracks

    @@track_collections = {}

    def initialize(name, *args)
      @tracks = []
      @name = name
    end

    def self.all
      @@track_collections[token].values
    end

    def self.find_by_name(lookup_name)
      @@track_collections[token][lookup_name]
    end

    def self.find_or_create(lookup_name)
      unless @@track_collections[token]
        @@track_collections[token] = {}
      end
      @@track_collections[token][lookup_name] = self.new(lookup_name)
    end

    def add_track(track)
      @tracks << track
    end

    def track_count
      @track_count ||= tracks.count
    end

    def star_rating
      return nil if rated_tracks.empty?      
      rated_tracks.map(&:star_rating).sum / rated_tracks.size
    end

    protected

    def rated_tracks
      @rated_tracks ||= tracks.select{|t| t.rated?}
    end

    def self.token
      self.class.name
    end

    def token
      self.class.token
    end

  end
end