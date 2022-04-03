Dir[File.join(__dir__, '.', '*.rb')].each { |file| require file }
require 'plist'

module AppleMusicLibrary
  class Library
  
    include Utils

    MUSIC_FORMATS = [
      'AAC audio file',
      'AIFF audio file',
      'Matched AAC audio file',
      'MPEG audio file',
      'MPEG-4 audio file',
      'Protected AAC audio file',
      'Purchased AAC audio file'
    ]

    attr_reader :plist

    def initialize(music_library_file_path, verbose = false)
      @verbose = verbose
      message("Initializing library with #{music_library_file_path}")

      unless File.file?(music_library_file_path)
        raise Error.new("Supplied library file path name does not exist: [#{music_library_file_path}]")
      end
      begin
        @plist = Plist.parse_xml(music_library_file_path)
      rescue => e
        raise Error, "Failed to parse library xml file [#{e.message}]"
      end

      extract_plist_info
    end

    def albums
      @albums ||= Album.all
    end

    def artists(filter = nil, limit = nil)
      filter.present? ? Artist.send(filter, limit) : Artist.all
    end

    def artist(artist_name)
      Artist.find_by_name(artist_name)
    end

    def genres
      @genres ||= Genre.all
    end

    def genre(genre_name)
      Genre.find_by_name(genre_name)
    end

    def playlists(filter = nil)
      return Playlist.all unless filter
      Playlist.send(filter)
    end

    def playlist(playlist_name)
      Playlist.find_by_name(playlist_name)
    end

    def playlist_folders
      @playlist_folders ||= PlaylistFolder.all
    end

    def playlist_folder(playlist_folder_name)
      PlaylistFolder.find_by_name(playlist_folder_name)
    end

    def tracks(filter = nil)
      filter.present? ? Track.send(filter) : Track.all
    end

    def track(track_id)
      Track.find(track_id)
    end

    def years
      @years ||= Year.all
    end

    def decades
      @decades ||= Decade.all
    end

    def decades_report
      Decade.report
    end

    def centuries
      @centuries ||= Century.all
    end

    def centuries_report
      Century.report
    end

    def valid?
      has_tracks?
    end

    def has_tracks?
      tracks.any?
    end

    def rated_tracks
      tracks.select{|t| t.rated?}
    end

    private

    def extract_plist_info
      extract_tracks_from_plist
      extract_playlists_from_plist
    end

    def extract_tracks_from_plist
      non_music_formats = {}
      plist['Tracks'].each do |track|
        if MUSIC_FORMATS.include?(track[1]['Kind'])
          Track.new(track[1])
        else
          non_music_formats[track[1]['Kind']] = true
        end
      end

      if non_music_formats.any?
        message("Skipped the following non-music formats:\n#{non_music_formats.keys.join(', ')}")
      end

    end

    def extract_playlists_from_plist
      plist['Playlists'].each do |playlist_info|
        # The distinction between playlists and playlist folders
        #   is made inside the Playlist instantiation
        Playlist.new(playlist_info)
      end
    end

  end

end