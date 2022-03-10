# <key>Name</key><string>Non-XTC</string>
# <key>Description</key><string></string>
# <key>Playlist ID</key><integer>79359</integer>
# <key>Playlist Persistent ID</key><string>59C95825DF1F0DCC</string>
# <key>All Items</key><true/>
# <key>Smart Info</key>
# <data>
# AQEAAwAAAAIAAAAZAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# AAAAAA==
# </data>
# <key>Smart Criteria</key>
# <data>

require 'facets'

module AppleMusicLibrary
  class Playlist

    attr_reader :info, :tracks

    ATTRIBUTES = ['Name',
                  'Description',
                  'Playlist ID',
                  'Playlist Persistent ID',
                  'All Items',
                  'Smart Info',
                  'Smart Criteria',
                  'Playlist Items',
                  'Folder']

    def initialize(info, library)
      @info = info
      @library = library
      @tracks = []

      load_tracks
    end

    def id
      playlist_id
    end                

    ATTRIBUTES.each do |attribute|
      define_method(attribute.to_s.snakecase) do
        info[attribute]
      end
    end

    def folder?
      folder.present?
    end

    private

    def load_tracks
      if playlist_items and playlist_items.any?
        playlist_items.each do |playlist_item|
          track_id = playlist_item['Track ID']
          track = @library.track(track_id)
          @tracks << track
        end
      end
    end

    
  end
end
