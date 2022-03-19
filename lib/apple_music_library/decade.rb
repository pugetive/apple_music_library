require_relative 'track_collection'

module AppleMusicLibrary
  class Decade < TrackCollection

    def self.report
      self.all.sort_by{|d| d.name}.each do |decade|
        puts "#{decade.name} - #{decade.track_count} tracks on #{decade.album_count} albums"
      end
    end

    def self.find_or_create_for(year_name)
      decade_start_year = year_name.to_i - (year_name.to_i % 10)
      decade_stop_year = decade_start_year + 9
      decade_name = "#{decade_start_year}-#{decade_stop_year}"

      self.find_or_create(decade_name)
    end

    def self.token
      :decade
    end

  end
end