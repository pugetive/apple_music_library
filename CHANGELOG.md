# Changelog

## [Unreleased]
- Ability to print out playlist folder hierarchy

## 0.14.0 - 2022-04-03
### Added
- Added Century model to retrieve track and album info per century (useful if you set classical pieces to their year of authorship rather than year of release)

## 0.13.2 - 2022-03-16
### Fixed
- Fixed bug where tracks with empty artist names would throw an exception

## 0.13.1 - 2022-03-16
### Fixed
- Now strips leading/trailing whitespace from artist and track names

## 0.13.0 - 2022-03-26
### Added
- Added handling for system verses user-created playlists

## 0.12.0 - 2022-03-26
### Added
- Added handling for smart versus regular playlists

## 0.11.0 - 2022-03-19
### Added
- Added Decade model to retrieve track and album info per decade

## 0.10.0 - 2022-03-16
### Fixed
- Fixed incorrect handling of tracks when added to track collections
### Added
- Added Year model to retrieve tracks and track counts per year of release

## 0.9.0 - 2022-03-15
### Added
- Ability to get genres associated with an artist

## 0.8.0 - 2022-03-13
### Added
- Ability to sort artists by track count and album count

## 0.7.0 - 2022-03-12
### Added
- Average star ratings for track collectsion (albums, playlists, genres)

## 0.6.0 - 2022-03-11
### Added
- Ability to list top artists by play count

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

