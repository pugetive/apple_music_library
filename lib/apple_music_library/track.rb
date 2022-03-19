require 'facets'

module AppleMusicLibrary
  class Track
    attr_reader :artist, :album, :genre

                  # 'Artist', The #artist, #album, and #genre methods return objects rather than strings and have methods like #artist_name to retrieve the strings.
                  # 'Album',
                  # 'Genre',
    ATTRIBUTES = ['Track ID', 
                  'Name',
                  'Kind',
                  'Size',
                  'Total Time',
                  'Track Number',
                  'Year',
                  'Date Modified',
                  'Date Added',
                  'Bit Rate',
                  'Sample Rate',
                  'Play Count',
                  'Play Date',
                  'Play Date UTC',
                  'Rating',
                  'Album Rating',
                  'Album Rating Computed',
                  'Loved',
                  'Normalization',
                  'Persistent ID',
                  'Track Type',
                  'Location',
                  'File Folder Count',
                  'Library Folder Count']

    @@tracks = {}

    def initialize(info)
      @info = info
      @artist = Artist.find_or_create(artist_name)
      @album = Album.find_or_create(@artist, album_name)
      # if name.match(/Humble.*demo/)
      #   puts "Adding track #{name} to album #{album_name}"
      # end
      @genre = Genre.find_or_create(genre_name)

      if year_name.present?
        @year = Year.find_or_create(year_name)
        @year.add_track(self)

        @decade = Decade.find_or_create_for(year_name)
        @decade.add_track(self)
      end

      @artist.add_track(self)
      @artist.add_album(@album)
      @album.add_track(self)
      @genre.add_track(self)
      @@tracks[id] = self
    end


    def self.find(track_id)
      @@tracks[track_id]
    end

    def self.all
      @@tracks.values
    end

    def self.loved
      @loved ||= self.all.select{|t| t.loved?}
    end

    def id
      track_id
    end      

    def artist_name
      @info['Artist']
    end

    def album_name
      @info['Album']
    end

    def genre_name
      @info['Genre']
    end

    def year_name
      @info['Year']
    end

    def star_rating
      rating / 20
    end

    def rated?
      rating > 0 and rating <= 100
    end

    def loved?
      loved
    end

    ATTRIBUTES.each do |track_attribute|
      define_method(track_attribute.to_s.snakecase) do
        @info[track_attribute]
      end
    end

    # def slug
    #   "#{name}::#{artist.name}::#{album}::#{disc_number}::#{track_number}"
    # end
  
  end
end

