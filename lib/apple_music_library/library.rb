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

      extract_plist_info
    end

    def albums
      @albums ||= Album.all
    end

    def artists
      @artists ||= Artist.all
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

    def playlists
      @playlists ||= Playlist.all
    end

    def playlist(playlist_name)
      Playlist.find_by_name(playlist_name)
    end

    def tracks
      @tracks ||= Track.all
    end

    def track(track_id)
      Track.find(track_id)
    end

    def valid?
      has_tracks?
    end

    def has_tracks?
      tracks.any?
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
        Playlist.new(playlist_info, self)
      end
    end





    # def track(track_id)
    #   track = @tracks_hash[track_id.to_i]
    #   if track.nil?
    #     message("Cound not find track with ID [#{track_id}]")
    #     message("Searched tracks: [#{@tracks_hash.keys.sort.join(', ')}]")
    #   end
    #   track
    # end

    # private

    # def extract_plist_info
    #   non_music_formats = {}
    #   plist['Tracks'].each do |track|
    #     if MUSIC_FORMATS.include?(track[1]['Kind'])
    #       track = Track.new(track[1])
    #       # next if track.artist.name == 'NPR'
    #       @tracks_hash[track.id] = track
    #       # @locations_hash[track.location] = track

    #       artist = Artist.find_or_create(track.artist_name)
    #       album = add_track_to_album(track, track.album)
    #       artist.add_album(album)

    #       if track.genre_name.present?
    #         genre = add_track_to_genre(track)
    #       end
    #     else
    #       non_music_formats[track[1]['Kind']] = true
    #     end
    #   end

    #   plist['Playlists'].each do |playlist_info|
    #     playlist = Playlist.new(playlist_info, self)
    #     next if playlist.folder?
    #     @playlists_hash[playlist.id] = playlist
    #   end

    #   if non_music_formats.any?
    #     message("Skipped the following non-music formats:\n#{non_music_formats.keys.join(', ')}")
    #   end
    # end


    # def add_artist(artist)      
    #   Artist.find_or_create(artist_name)
    # end

    # def add_track_to_album(track, album)
    #   unless album = @albums_hash[album.id]
    #     @albums_hash[album.id] = album
    #   end
    #   album.add_track(track)
    #   album
    # end

    # def find_or_create_album(album)
    #   unless @albums_hash[album.id]
    #     @albums_hash[album.id] = album
    #   end
    #   album.artist.add_album(album)
    # end


    # def add_track_to_genre(track)
    #   if @genres_hash[track.genre_name]
    #     return @genres_hash[track.genre_name]
    #   end
    #     # message("Creating new artist #{artist.name}")
    #   genre = AppleMusicLibrary::Genre.new(track.genre_name)
    #   @genres_hash[track.genre_name] = genre
    #   genre.add_track(track)
    #   genre
    # end

  end

end