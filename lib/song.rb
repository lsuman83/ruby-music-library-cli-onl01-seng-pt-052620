require 'pry'

class Song

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)

        @name = name
        self.artist = artist if artist
        self.genre = genre if genre

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

    def self.create(name, artist = nil, genre = nil)

        self.new(name, artist, genre).tap {|s| s.save}

    end

    def self.find_by_name(name)

        self.all.detect {|n| n.name == name}

    end

    def self.find_or_create_by_name(name)

        self.find_by_name(name) || self.create(name)

    end

    def self.new_from_filename(name)

        artist, name, genre = name.chomp(".mp3").split(" - ")
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre)
        self.new(name, artist, genre).tap {|s| s.save}
        
    end

    def self.create_from_filename(song_instance)
        
        self.new_from_filename(song_instance)
        
    end

    def artist=(artist)

        @artist = artist
        artist.add_song(self)

    end
    
    def genre=(genre)

        @genre = genre
        genre.songs << self unless genre.songs.include?(self)

    end
    


end