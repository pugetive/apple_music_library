require 'facets'
require_relative 'track_collection'

module AppleMusicLibrary
  class Playlist < TrackCollection

    attr_reader :info

    @@playlists = {}

    ATTRIBUTES = ['Name',
                  'Description',
                  'Playlist ID',
                  'Playlist Persistent ID',
                  'Parent Persistent ID',
                  'All Items',
                  'Smart Info',
                  'Smart Criteria',
                  'Playlist Items',
                  'Folder']

    def initialize(info)
      @info = info

      if folder?
        return PlaylistFolder.new(info)
      end

      super

      load_tracks

      @@playlists[id] = self
    end

    def self.all
      @@playlists.values
    end

    def self.find_by_name(playlist_name)
      results = @@playlists.values.select{|p| p.name == playlist_name}
      if results.size == 1
        return results.first
      end
      results
    end

    def id
      playlist_persistent_id
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
          track = Track.find(track_id)
          @tracks << track
        end
      end
    end

    
  end
end

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

