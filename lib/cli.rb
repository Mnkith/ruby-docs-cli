class CLI
  @@INS_PREFIX = '>>>'.colorize(:green)
  @@SEPARATOR = "\n********************************************************************\n".colorize(:light_blue)

  @@main_prompt = "ruby-2.7.2-docs".colorize(:light_blue)
  
  def self.docs
    puts "Welcome to your Ruby docs!"
    puts "A gem that enables you to display full description of Ruby " 
    puts "core classess and methods right from your IDE terminal."
    puts

    user_input = ""
    while true

      puts "#{@@INS_PREFIX}To list all of Ruby classes, enter #{'classes'.colorize(:yellow)}."
      puts "#{@@INS_PREFIX}To quit, type #{'exit'.colorize(:yellow)}."
      puts


      STDOUT << @@main_prompt << ":> "

      user_input = gets.strip.downcase

      if user_input == "exit"
        exit(0)
      elsif user_input == "classes"
        all_classes_menu
      else
        puts "Sorry, ruby-docs doesn't recognize '".colorize(:red) + "#{user_input}".colorize(:yellow) + "' as internal command.".colorize(:red)
        puts
      end
    end
  end
  def self.all_classes_menu
    user_input = ""
    Klass.all.each{|klass| puts klass.name}
    until user_input == 'back'
      puts @@SEPARATOR
      puts "#{@@INS_PREFIX}To see a full description of particular class, enter the class name."
      puts "#{@@INS_PREFIX}To go back to the previous menu, enter #{'back'.colorize(:yellow)}."
      puts "#{@@INS_PREFIX}To exit type #{'exit'.colorize(:yellow)}"
      puts
      STDOUT << "#{@@main_prompt}/#{'classes'.colorize(:yellow)}:> "
      user_input = gets.strip.downcase
      if user_input == 'exit'
        exit(0)
      elsif user_input != 'back' && class_name = Klass.validate(user_input)
        k = Klass.new(class_name)
        puts k.description
        in_class_menu(k)
      end
    end

  end

  def self.in_class_menu(klass)
    user_input = ""
    until user_input == 'back'
      puts @@SEPARATOR
      puts "#{@@INS_PREFIX}To list all methods under the #{klass.name.colorize(:yellow)} c"+"lass, enter #{'methods'.colorize(:yellow)}."
      puts "#{@@INS_PREFIX}To see a full description of particular method, enter the method name."
      puts "#{@@INS_PREFIX}To go back to the to the previous menu, enter #{'back'.colorize(:yellow)}."
      puts "#{@@INS_PREFIX}To exit type #{'exit'.colorize(:yellow)}"
      puts 

      STDOUT << "#{@@main_prompt}/classes/#{klass.name.colorize(:yellow)}:> "

      user_input = gets.strip.downcase

      if user_input == 'exit'
          exit(0)
      elsif user_input == 'methods'
          puts klass.class_methods
      elsif user_input != 'back'
        Mmethod.all = klass.class_methods
        if method_name = Mmethod.validate(user_input)
          system "clear" 
          # STDOUT << "ruby-2.7.2-docs/classes/#{klass.name.colorize(:yellow)}/#{method_name.colorize(:yellow)}:>) "
          puts Mmethod.new(method_name, klass).description
        end
      end
    end
  end
end