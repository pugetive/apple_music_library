require_relative 'track_collection'

module AppleMusicLibrary
  class Album < TrackCollection
    attr_reader :artist


    attr_reader :artist

    @@albums = {}

    def initialize(artist, album_name)
      @artist = artist
      @album_name = album_name
      super
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

    def name
      @album_name
    end

    def year
      @year ||= @tracks.sort_by(&:year).last.year
    end

    def dump
      puts "#{artist.name} - #{name}"
      tracks.each do |track|
        puts "\t#{track.name}"
      end
    end

  end
end
