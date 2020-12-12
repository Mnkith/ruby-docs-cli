require_relative './models/klass'
require_relative './models/mmethod'
require_relative './scraper.rb'
require 'pry'
require 'tty/box'


class CLI

  def self.docs
    user_input = ""

    while user_input != "exit"
      # box = TTY::Box.frame(width: 30, height: 10) do
        puts "Welcome to your Ruby docs!"
        puts "   A gem that enables you to display full description of Ruby"
      # end
      puts "core classess and methods right from your IDE terminal"
      puts "To list all of Ruby classes, enter 'classes'."
      puts "To quit, type 'exit'."
      # $stdout << "Hello " << "world!"
      user_input = gets.strip

      if user_input == "exit"
        exit(0)
      elsif user_input == "classes"
        all_classes_menu
      else
        puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command."
      end
    end
  end
  def self.all_classes_menu
    user_input = ""
    puts Klass.all
    until user_input == 'back'
      puts '********************************************************************'
      puts '>>>>>To see a full description of particular class, enter the c'+'lass name.'
      puts '>>>>>To go back to the previous menu, enter "back".'
      puts '>>>>>To exit type "exit"'
      print "ruby.docs.all-classes>>>"
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
      print "ruby.docs.#{klass.name}>>>"
      user_input = gets.strip
      if user_input == 'exit'
          exit(0)
      elsif user_input == 'mm'
          puts klass.class_methods
      elsif user_input != 'back'
        Mmethod.all = klass.class_methods
        if Mmethod.validate(user_input)
          puts Mmethod.new(user_input, klass).description
        end
      end
    end
  end
end

CLI.docs