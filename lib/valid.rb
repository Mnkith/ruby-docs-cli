

module Valid
  def suggest(user_input)
    if user_input.length >= 3
      s = ".*#{user_input.split('').join('.*{1}')}.*"
      pattern = Regexp.new(s)
      suggestions = self.all.select{|el| el.name.downcase =~ pattern}
      if suggestions.empty?
        puts "\nSorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
      else
        puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
        puts "Did you mean?\n"
        suggestions.each{|e| puts e.name.colorize(:green)}
      end
    else
       puts "\nSorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
    end
  end

  def validate(user_input) #return the method or class object based on user input if found other wise nil
    self.all.each{|el| return el if el.name.downcase.gsub(/[#:]/, '') == user_input.downcase}
    suggest(user_input)
    nil
  end
end