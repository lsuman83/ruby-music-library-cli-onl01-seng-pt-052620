require 'pry'
class MusicImporter

    attr_accessor :path, :file

    def initialize(path)

        @path = path

    end

    def files

        @file = Dir.entries(@path).select {|music| music.include?(".mp3")}

    end

    def import

        files.each do |song|
            Song.create_from_filename(song)
        end

    end


end