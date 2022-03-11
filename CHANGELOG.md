# Changelog

## [Unreleased]
- Ability to print out playlist folder hierarchy

## 0.5.0 - 2022-03-11
### Added
- Basic functionality for track ratings via the #rating, #star_rating, and #loved

## 0.4.0 - 2022-03-11
### Added
- Basic functionality for Playlist Folders
### Fixed
- The #find_by_name methods for Playlists and PlaylistFolders now return a single object when only a single exact match is found (the most common case) but continue to return an array of objects when there are multiple matches.

## 0.3.0 - 2022-03-10

### Fixed
- Fixed handling of albums, genres, and playlists as accessed via methods on artists/tracks.

## 0.2.0 - 2022-03-10
### Added
- Basic functionality to parse a library plist into Track, Album, Artist, Genre, and Playlist objects.

