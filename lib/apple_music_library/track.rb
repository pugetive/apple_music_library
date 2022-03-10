require 'facets'

module AppleMusicLibrary
  class Track
    attr_reader :info, :artist, :album

    ATTRIBUTES = ['Track ID', 
                  'Name',
                  # 'Artist', The #artist, #album, and #genre methods return objects rather than strings and have methods like #artist_name to retrieve the strings.
                  # 'Album',
                  # 'Genre',
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
                  'Normalization',
                  'Persistent ID',
                  'Track Type',
                  'Location',
                  'File Folder Count',
                  'Library Folder Count']

    def initialize(info)
      @info = info
      @artist = Artist.new(artist_name)
      @album = Album.new(@artist, album_name)
    end

    def id
      track_id
    end      

    def artist_name
      info['Artist']
    end

    def album_name
      info['Album']
    end

    def genre_name
      info['Genre']
    end

    ATTRIBUTES.each do |attribute|
      define_method(attribute.to_s.snakecase) do
        info[attribute]
      end

    end

    # def slug
    #   "#{name}::#{artist.name}::#{album}::#{disc_number}::#{track_number}"
    # end
  
  end
end

