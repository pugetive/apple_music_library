# AppleMusicLibrary

The `apple_music_library` gem offeres a ruby interface to the information stored in an iTunes / Apple Muisic `Library.xml` file, as can be generated with the app's menu option `File > Library > Export Library...`

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

# Show tracks in a specific playlist
playlist = library.playlist('XTC Favorites').first
playlist.tracks.each do |track|
  puts track.name
end

# Count tracks by artist
artist = library.artist('XTC')
puts artist.tracks.count

# Display track counts per genre
library.genres.each do |genre|
  puts "#{genre.tracks.count} #{genre.name}"
end
```
All stored attributes are available via snake_cased methods on `Track` and `Playlist`. However, note that `#artist`, `#album`, and `#genre` are special cases, returning Ruby objects rather than their associated string values. Methods to return the string versions of these track attributes are provided as `track.artist_name`, `track.album_name`, and `track.genre_name`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pugetive/apple-music-library.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

