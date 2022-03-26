# AppleMusicLibrary

The `apple_music_library` gem offeres a ruby interface to the information stored in an iTunes / Apple Muisic `Library.xml` file, as can be generated with the app's menu option `File > Library > Export Library...`

[![Maintainability](https://api.codeclimate.com/v1/badges/86a57ad0904e4358dd02/maintainability)](https://codeclimate.com/github/pugetive/apple_music_library/maintainability)



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple_music_library'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install apple_music_library

## Usage

```ruby

# Create library
library = AppleMusicLibrary.new('path/to/Library.xml')

# Count albums
puts library.albums.count

# Show playlists contained in a playlist folder
playlist_folder = library.playlist_folder('Folder for Testing')
playlist_folder.playlists.each do |playlist|
  puts playlist.name
end

# List all playlists
library.playlists.each do |playlist|
  puts playlist.name
end

# List only 'smart' playlists
library.playlists(:smart).each do |playlist|
  puts playlist.name
end

# List all regular (not 'smart') playlists
library.playlists(:regular).each do |playlist|
  puts playlist.name
end


# Show tracks in a specific playlist
playlist = library.playlist('XTC Favorites')
playlist.tracks.each do |track|
  puts track.name
end

# Count tracks by an artist
artist = library.artist('XTC')
puts artist.tracks.count

# List genres associated with the artist
artist.genres.each do |genre|
  puts genre.name
end

# Get favorite tracks by this artist
favorite_tracks = artist.tracks.select{|t| t.loved? || t.star_rating > 3}

# List out the most played artists
library.artists(:most_played).each do |artist|
  puts "#{artist.play_count} :: #{artist.name}"
end

# List out artists with the most tracks
library.artists(:most_tracks).each do |artist|
  puts "#{artist.track_count} :: #{artist.name}"
end

# List out artists with the most albums
library.artists(:most_albums).each do |artist|
  puts "#{artist.album_count} :: #{artist.name}"
end

# Display track counts per genre
library.genres.each do |genre|
  puts "#{genre.track_count} #{genre.name}"
end

# Display track counts per year
library.years.each do |year|
  puts "#{year.track_count} #{year.name}"
end

# Display track counts per decade
library.decades.each do |decade|
  puts "#{decade.track_count} #{decade.name}"
end

# Print a report on all decades in the library
#   e.g.
# 1970-1979 - 336 tracks on 10 albums
# 1980-1989 - 816 tracks on 16 albums
# 1990-1999 - 300 tracks on 8 albums
# 2000-2009 - 110 tracks on 5 albums
library.decades_report



```
All stored attributes are available via snake_cased methods on `Track` and `Playlist`. However, note that `#artist`, `#album`, and `#genre` are special cases, returning Ruby objects rather than their associated string values. Methods to return the string versions of these track attributes are provided as `track.artist_name`, `track.album_name`, and `track.genre_name`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pugetive/apple-music-library.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

