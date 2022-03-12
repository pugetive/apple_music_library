module AppleMusicLibrary
  class TrackCollection

    attr_reader :name, :tracks

    def initialize(name, *args)
      @tracks = []
      @name = name
    end

    def add_track(track)
      @tracks << track
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