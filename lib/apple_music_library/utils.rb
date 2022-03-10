require 'awesome_print'

module AppleMusicLibrary
  module Utils

    def message(text)
      return unless @verbose
      puts "---------------------------------------------------------------------------"
      puts "DEV MESSAGE @ #{Time.now.strftime('%H:%M:%S')} ::: #{text}"
      puts "---------------------------------------------------------------------------"
    end

    def heading(text)
      puts
      puts "---------------------------------------------------------------------------"
      puts "#{text} [#{delimit(songs.size)} songs]"
      puts "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    end

    def delimit(number)
      number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def dump
      ap plist
    end
  end
end
