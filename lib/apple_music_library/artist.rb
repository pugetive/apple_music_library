module AppleMusicLibrary
  class Artist

    attr_reader :name

    def initialize(name)
      @name = name
      @albums = []
    end

    def add_album(album)
      unless albums.include?(album)
        @albums << album
      end
    end


    def albums
      @albums.sort(&:year)
    end

    def tracks
      @tracks ||= @albums.map(&:tracks).flatten
    end

  end
end
