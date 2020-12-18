
require_relative 'environment'
module Scraper
    module ClassMethods

  @@main_uri = "https://ruby-doc.org/core-2.7.2/" 

    def get_elements(element_locator, page)
      doc = Nokogiri::HTML(open(page))
      elements = doc.css(element_locator)
      # binding.pry
      elements.map{|element| element.text}
    end

    def main_uri
      @@main_uri
    end

    def suggest(user_input)
      if user_input.length >= 3
        s = ".*#{user_input.split('').join('.*{1}')}.*"
        pattern = Regexp.new(s)
        suggestions = self.all.name.select{|el| el.downcase =~ pattern}
        if suggestions.empty? 
          
          puts "\nSorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
        else
          puts "\nSorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
          puts "Did you mean?"
          puts suggestions
        end
      else
         puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
      end

    end
    
    def validate(user_input) #return the valid name of method or class based on user input if found other wise nil
      self.all.each{|el| return el.name if el.name.downcase.gsub(/[#:]/, '') == user_input.downcase}
      suggest(user_input)
      nil
    end
  end
  
  module InstanceMethods
    def descripe
      if self.class == Klass
        self.class.get_elements('div#documentation div#description.description', self.sub_page)
      else
        id = self.normalized_name
        call =  self.class.get_elements("div##{id}.method-detail span.method-callseq", self.class_sub_page)
        details = self.class.get_elements("div##{id}.method-detail div p", self.class_sub_page)
        code = self.class.get_elements("div##{id}.method-detail div pre", self.class_sub_page)
        call.concat(details, code)
      end
    end
  end
end
