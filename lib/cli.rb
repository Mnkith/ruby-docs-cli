require_relative './models/klass'
require_relative './models/mmethod'
require_relative './scraper.rb'
require 'pry'


class CLI

  def self.docs
    input = ""

    while input != "exit"
      puts "Welcome to your Ruby docs!"
      puts "A gem that enables you to display full description of Ruby"
      puts "core classess and methods right from your IDE terminal"
      puts "To list all of Ruby classes, enter 'classes'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      user_input = gets.strip

      case user_input
      when "classes"
        puts Klass.all
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end
  def self in_class_loop
    until user_input == 'back'
      puts Klass.all
      puts '********************************************************************'
      puts 'To see a full description of particular class, enter the class name.'
      puts 'To go back to the main menu, enter "back".'
      user_input = gets.strip
      case user_input
      when ""

  end

CLI.docs