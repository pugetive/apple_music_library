module AppleMusicLibrary
  class Genre < TrackCollection

    attr_reader :name

    @@genres = {}

    def initialize(name)
      @name = name
      super
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

  end
end
