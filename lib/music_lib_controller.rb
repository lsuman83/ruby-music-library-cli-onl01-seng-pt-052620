require 'pry'

class MusicLibraryController

    attr_accessor :path

    def initialize(path = "./db/mp3s")

        @path = path
        song = MusicImporter.new(path)
        song.import

    end

    

    def call

       puts "Welcome to your music library!"
       puts "To list all of your songs, enter 'list songs'."
       puts "To list all of the artists in your library, enter 'list artists'."
       puts "To list all of the genres in your library, enter 'list genres'."
       puts "To list all of the songs by a particular artist, enter 'list artist'."
       puts "To list all of the songs of a particular genre, enter 'list genre'."
       puts "To play a song, enter 'play song'."
       puts "To quit, type 'exit'."
       puts "What would you like to do?"
       input = nil


       while input != "exit" do
        input = gets.strip
        case input
        when 'list songs'
            list_songs
        when 'list artists'
            list_artists
        when 'list genres'
            list_genres
        when 'list artist'
            list_songs_by_artist
        when 'list genre'
            list_songs_by_genre
        when 'play song'
            play_song
        end
            
       end

    end

    def list_songs

        songs = Song.all
        songs.sort_by! {|song| song.name}
        songs.map.with_index(1) do |song, index|
             puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    
    end

    def list_artists

        artists = Artist.all
        artists.sort_by! {|singer| singer.name}
        artists.map.with_index(1) do |singer, index|
            puts "#{index}. #{singer.name}" 
        end

    end

    def list_genres

        genres = Genre.all
        genres.sort_by! {|song| song.name}
        genres.map.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}"
        end

    end

    def list_songs_by_artist

        puts "Please enter the name of an artist:"
        input_artist = gets.strip

        index = 1
        Song.all.sort_by! {|song| song.name}
        Song.all.map do |songs|
            if songs.artist.name == input_artist
                puts "#{index}. #{songs.name} - #{songs.genre.name}"
                index += 1
            end
        end
        

    end

    def list_songs_by_genre

        puts "Please enter the name of a genre:"
        input_genre = gets.strip

        index = 1
        Song.all.sort_by! {|song| song.name}
        Song.all.map do |songs|
            if songs.genre.name == input_genre
                puts "#{index}. #{songs.artist.name} - #{songs.name}"
                index += 1
            end
        end


        
    end

    def play_song

        puts "Which song number would you like to play?"
        input_song = gets.strip

        if input_song.to_i > 0 && input_song.to_i <= Song.all.length
            song_list = Song.all.sort_by! {|song| song.name}
            song = song_list[input_song.to_i - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end

        
    end


end