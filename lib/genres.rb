class Genre

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

        genre = Genre.new(name)
        genre.save
        genre

    end

    def artists

        self.songs.collect {|song| song.artist}.uniq

    end

    def songs

       Song.all.select {|song_genre| song_genre.genre == self}

    end


end