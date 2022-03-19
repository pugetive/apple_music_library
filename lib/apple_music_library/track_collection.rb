module AppleMusicLibrary
  class TrackCollection

    attr_reader :name, :tracks

    @@track_collections = {}

    def initialize(name, *args)
      @tracks = []
      @name = name.present? ? name : 'Unknown'
    end

    def self.all
      @@track_collections[token].values
    end

    def self.find_by_name(lookup_name)
      @@track_collections[token][lookup_name]
    end

    def self.find_or_create(lookup_name)
      if lookup_name.blank?
        lookup_name = 'Unknown'
      end
      # puts "Finding or creating #{token}: #{lookup_name}"
      unless @@track_collections[token]
        @@track_collections[token] = {}
      end
      if @@track_collections[token][lookup_name]
        # puts "FOUND"
        return @@track_collections[token][lookup_name]
      end
      # puts "CREATING"
      @@track_collections[token][lookup_name] = self.new(lookup_name)
    end

    def add_track(track)
      # puts "Adding #{track.name} to #{self.class.token} #{name}"
      @tracks << track
    end

    def track_count
      @track_count ||= tracks.count
    end

    def album_count
      @ablum_count ||= tracks.map(&:album).uniq.count
    end

    def star_rating
      return nil if rated_tracks.empty?      
      rated_tracks.map(&:star_rating).sum / rated_tracks.size
    end

    protected

    def rated_tracks
      @rated_tracks ||= tracks.select{|t| t.rated?}
    end


  end
end