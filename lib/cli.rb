require_relative './models/klass'
require_relative './models/mmethod'
require_relative './scraper.rb'
require 'pry'


class CLI

  def self.docs
    user_input = ""

    while user_input != "exit"
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
        all_classes_menu
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
  def self.all_classes_menu
    user_input = ""
    puts Klass.all
    until user_input == 'back'
      puts '********************************************************************'
      puts '>>>>To see a full description of particular c'+'lass, enter the c'+'lass name.'
      puts '>>>>To go back to the previous menu, enter "back".'
      puts '>>>>>To exit type "exit"'
      user_input = gets.strip
      if class_name = Klass.validate(user_input)
        k = Klass.new(class_name)
        puts k.description
        in_class_menu(k)
      elsif user_input == 'exit'
      exit(0)
      end
    end

  end

  def self.in_class_menu(klass)
    user_input = ""
    until user_input == 'back'
      puts '********************************************************************'
      puts ">>>>>To list all methods under the #{klass.name} c"+"lass, enter mm."
      puts ">>>>>To see a full description of particular method, enter the method name."
      puts '>>>>>To go back to the to the previous menu, enter "back".'
      puts '>>>>>To exit type "exit"'
      user_input = gets.strip
      if user_input == 'exit'
        exit(0)
      elsif user_input == 'mm'
        puts klass.class_methods
      elsif user_input != 'back'
        puts Mmethod.new(user_input, klass).description
          
        
      end
    end
  end
end

CLI.docs