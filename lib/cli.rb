require_relative './models/klass'
require_relative './models/mmethod'
require_relative './scraper.rb'
require "bundler/setup"
require 'colorize'
# require 'pry'
require 'tty/box'


class CLI

  def self.docs
    puts "Welcome to your Ruby docs!"
    puts "A gem that enables you to display full description of Ruby " 
    puts "core classess and methods right from your IDE terminal."
    user_input = ""
    ins_prefix = '>>>>>'.colorize(:green)
    while user_input != "exit"
      puts "Welcome to your Ruby docs!"
      puts "A gem that enables you to display full description of Ruby "
      puts "core classess and methods right from your IDE terminal."
      puts "#{ins_prefix}To list all of Ruby classes, enter #{'classes'.colorize(:yellow)}."
      puts "#{ins_prefix}To quit, type #{'exit'.colorize(:yellow)}."
      # $stdout << "Hello " << "world!"
      user_input = gets.strip

      if user_input == "exit"
        exit(0)
      elsif user_input == "classes"
        all_classes_menu
      else
        puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
      end
    end
  end
  def self.all_classes_menu
    user_input = ""
    puts Klass.all
    until user_input == 'back'
      puts '********************************************************************'
      puts "#{ins_prefix}To see a full description of particular class, enter the class name."
      puts "#{ins_prefix}To go back to the previous menu, enter #{'back'.colorize(:yellow)}."
      puts "#{ins_prefix}To exit type #{'exit'.colorize(:yellow)}"
      print "ruby.docs.all-classes>>>"
      user_input = gets.strip
      if user_input == 'exit'
      exit(0)
      elsif class_name = Klass.validate(user_input)
        k = Klass.new(class_name)
        puts k.description
        in_class_menu(k)
      end
    end

  end

  def self.in_class_menu(klass)
    user_input = ""
    until user_input == 'back'
      puts '********************************************************************'
      puts "#{ins_prefix}To list all methods under the #{klass.name.colorize(:yellow)} c"+"lass, enter #{'methods'.colorize(:yellow)}."
      puts "#{ins_prefix}To see a full description of particular method, enter the method name."
      puts "#{ins_prefix}To go back to the to the previous menu, enter #{'back'.colorize(:yellow)}."
      puts "#{ins_prefix}To exit type 'exit'.colorize(:yellow)}"
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
# box = TTY::Box.frame "Drawing a box in", "terminal emulator", padding: 3, align: :center
# print box
CLI.docs