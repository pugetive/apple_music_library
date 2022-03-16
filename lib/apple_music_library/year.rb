require_relative 'track_collection'

module AppleMusicLibrary
  class Year < TrackCollection

    def self.dump
      self.all.sort_by{|y| y.name}.each do |year|
        puts "#{year.name} - #{year.track_count} tracks"
        # year.tracks.each do |track|
        #   puts "\t#{track.name}"
        # end
      end
    end

    def self.token
      :year
    end

  end
end