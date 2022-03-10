module AppleMusicLibrary
  class Genre

    attr_reader :name, :tracks

    @@genres = {}

    def initialize(name)
      @name = name
      @tracks = []
    end

    def self.all
      @@genres.values
    end
    
    def self.find_or_create(name)
      if @@genres[name]
        return @@genres[name]
      end
      @@genres[name] = self.new(name)
    end

    def self.find_by_name(name)
      @@genres[name]
    end

    def add_track(track)
      unless tracks.include?(track)
        @tracks << track
      end
    end

  end
end
