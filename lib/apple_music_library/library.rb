require_relative 'album'
require_relative 'artist'
require_relative 'genre'
require_relative 'playlist'
require_relative 'track'
require_relative "utils"
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

      @artists_hash   = {}
      @tracks_hash    = {}
      @playlists_hash = {}
      @albums_hash    = {}
      @genres_hash    = {}

      @locations_hash = {}
      @slugs_hash     = {}      

      extract_plist_info
    end

    def tracks
      @tracks_hash.values
    end

    def artists
      @artists_hash.values
    end

    def artist(artist_name)
      artists.find{|a| a.name == artist_name}
    end

    def albums
      @albums_hash.values
    end

    def playlists
      @playlists_hash.values
    end

    def playlist(playlist_name)
      playlists.find{|p| p.name == playlist_name}
    end


    def albums
      @albums_hash.values
    end

    def genres
      @genres_hash.values.sort_by{|g| g.name}
    end

    def genre(genre_name)
        genres.find{|g| g.name == genre_name}
    end

    def valid?
      has_tracks?
    end

    def has_tracks?
      tracks.any?
    end

    def track(track_id)
      track = @tracks_hash[track_id.to_i]
      if track.nil?
        message("Cound not find track with ID [#{track_id}]")
        message("Searched tracks: [#{@tracks_hash.keys.sort.join(', ')}]")
      end
      track
    end

    private

    def extract_plist_info
      non_music_formats = {}
      plist['Tracks'].each do |track|
        if MUSIC_FORMATS.include?(track[1]['Kind'])
          track = Track.new(track[1])
          # next if track.artist.name == 'NPR'
          @tracks_hash[track.id] = track
          # @locations_hash[track.location] = track

          artist = add_artist(track.artist)
          album = add_track_to_album(track, track.album)
          artist.add_album(album)

          if track.genre_name.present?
            genre = add_track_to_genre(track)
          end
        else
          non_music_formats[track[1]['Kind']] = true
        end
      end

      plist['Playlists'].each do |playlist_info|
        playlist = Playlist.new(playlist_info, self)
        next if playlist.folder?
        @playlists_hash[playlist.id] = playlist
      end

      if non_music_formats.any?
        message("Skipped the following non-music formats:\n#{non_music_formats.keys.join(', ')}")
      end
    end


    def add_artist(artist)
      unless @artists_hash[artist.name]
        @artists_hash[artist.name] = artist
      end
      artist
    end

    def add_track_to_album(track, album)
      return if @albums_hash[album.id]
      # message("Creating new artist #{artist.name}")
      @albums_hash[album.id] = album
      album.add_track(track)
      album
    end

    def find_or_create_album(album)
      unless @albums_hash[album.id]
        @albums_hash[album.id] = album
      end
      album.artist.add_album(album)
    end


    def add_track_to_genre(track)
      if @genres_hash[track.genre_name]
        return @genres_hash[track.genre_name]
      end
        # message("Creating new artist #{artist.name}")
      genre = AppleMusicLibrary::Genre.new(track.genre_name)
      @genres_hash[track.genre_name] = genre
      genre.add_track(track)
      genre
    end

  end

end