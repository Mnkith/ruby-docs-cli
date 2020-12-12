require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'
module Scraper
  module ClassMethods
  @@main_uri = "https://ruby-doc.org/core-2.7.2/" # not a constant because it's content will change dynamically
  # main_site = open(main_uri)                    # not a constant because it's content will change dynamically
    
    def get_elements(element_locator, page)
      doc = Nokogiri::HTML(open(page))
      elements = doc.css(element_locator)
      elements.map{|element| element.text}
    end

    def main_uri
      @@main_uri
    end

    def suggest(user_input)
      if user_input.length >= 3
        s = ".*#{user_input.split('').join('.*')}.*"
        pattern = Regexp.new(s)
        suggestions = self.all.select{|el| el.downcase =~ pattern}
        if suggestions.empty? 
          puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
        else
          puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
          puts "Did you mean?"
          puts suggestions
        end
      else
         puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)

    end
    
    # def normalize_uri(suffix = '')
    #   return @@main_uri + suffix.gsub(/::/, '/') + '.html' if suffix != ''
    #   @@main_uri
    # end
    def validate(user_input) #return the valid name of method or class based on user input if found other wise nil
      self.all.each{|el| return el if el.downcase.gsub(/[#:]/, '') == user_input.downcase}
      suggest(user_input)
      # puts "Sorry, ruby-docs doesn't recognize '#{user_input}' as internal command.".colorize(:red)
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
# css(".class")[2].children[1].text
# puts doc.css("#method-index")[1]
# puts doc.css(".class a").text
# all_classes_locator = "div#class-index div.entries p a"
# all_methods_locator = "div#method-list-section ul.link-list li"
# Scraper.display_content(Scraper.get_elemrnts(all_methods_locator, "Array.html")) 