require 'facets'

module AppleMusicLibrary
  class PlaylistFolder

    attr_reader :info

    @@playlist_folders = {}

    def initialize(info)
      @info = info

      @@playlist_folders[id] = self
    end

    def self.all
      @@playlist_folders.values
    end

    def self.find_by_name(playlist_folder_name)
      results = @@playlist_folders.values.select{|pf| pf.name == playlist_folder_name}
      if results.size == 1
        return results.first
      end
      results
    end

    def id
      playlist_persistent_id
    end                

    def children
      playlist_folders.concat(playlists)
    end

    def playlist_folders
      @@playlist_folders.values.select{|pf| pf.parent_persistent_id == id}
    end

    def playlists
      Playlist.all.select{|p| p.parent_persistent_id == id}
    end

    Playlist::ATTRIBUTES.each do |attribute|
      define_method(attribute.to_s.snakecase) do
        info[attribute]
      end
    end


    private


  end
end