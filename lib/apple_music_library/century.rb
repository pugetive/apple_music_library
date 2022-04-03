require_relative 'track_collection'

module AppleMusicLibrary
  class Century < TrackCollection

    def self.report
      self.all.sort_by{|c| c.name}.each do |century|
        puts "#{century.name} - #{century.track_count} tracks on #{century.album_count} albums"
      end
    end

    def self.find_or_create_for(century_name)
      century_start_year = century_name.to_i - (century_name.to_i % 100)
      century_stop_year = century_start_year + 99
      century_name = "#{century_start_year}'s"

      self.find_or_create(century_name)
    end

    def self.token
      :century
    end

  end
end