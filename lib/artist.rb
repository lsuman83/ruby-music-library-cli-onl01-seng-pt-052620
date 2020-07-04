require 'pry'
class Artist

    extend Concerns::Findable
    extend Concerns::Findable::ClassMethods

    attr_accessor :name

    @@all = []

    def initialize(name)

        @name = name  

    end

    def save

        @@all << self

    end

    def self.all

        @@all

    end

    def self.destroy_all

        self.all.clear

    end

    def self.create(name)

        artists = Artist.new(name)
        artists.save
        artists

    end

    def songs

        Song.all.select do |song|
            song.artist == self
        end

    end


    def add_song(song)  

        song.artist = self unless song.artist == self

    end

    def genres

        self.songs.collect {|song| song.genre}.uniq

    end

end
