module AppleMusicLibrary
  class Genre

    attr_reader :name, :tracks

    def initialize(name)
      @name = name
      @tracks = []
    end

    def add_track(track)
      unless tracks.include?(track)
        @tracks << track
      end
    end

  end
end
