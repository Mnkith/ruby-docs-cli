require 'nokogiri'
require 'open-uri'
require 'pry'
module Scraper 
  module ClassMethods
  @@main_uri = "https://ruby-doc.org/core-2.7.2/" # not a constant because it's content will change dynamically
  # main_site = open(main_uri)                    # not a constant because it's content will change dynamically
    
    def get_elements(element_locator, sub_page)
      # sub_page = open(normalize_uri(uri_suffix))
      doc = Nokogiri::HTML(open(sub_page))
      elements = doc.css(element_locator)
      elements.map{|element| element.text}
      # binding.pry
      # txt_ary = self.text_array(elements)
    end
    def main_uri
      @@main_uri
    end
    def suggest(user_input)
      s = ".*#{user_input.split('').join('.*')}.*"
      pattern = Regexp.new(s)
      self.all.select{|el| el.text.downcase =~ pattern}
    end
    
    # def normalize_uri(suffix = '')
    #   return @@main_uri + suffix.gsub(/::/, '/') + '.html' if suffix != ''
    #   @@main_uri
    # end

    def description(t)
      if t.class == Klass
        get_elements('div#documentation div#description.description', t.sub_page)
      else
        n = "#{t.normalized_name}method"
        call =  get_elements("div##{n}.method-detail span.method-callseq", t.klass_sub_page)
        details = get_elements("div##{n}.method-detail div p", t.klass_sub_page)
        code = get_elements("div##{n}.method-detail div pre", t.klass_sub_page)
        # binding.pry
        call.concat(details, code)
      end
    end
    def display_all(text_array)
      text_array.each_with_index {|el, i| puts "#{i+1}- #{el}"}
    end
    def validate(user_input) #return the valid name of method or class based on user input if found other wise nil
      self.all.each{|el| return el if el.downcase.gsub(/[#:]/, '') == user_input.downcase}
      nil
    end
    
  end
  
  module InstanceMethods
    
    def is_there?(user_input)
      searchable = self.all.map{|el| el.text.downcase}
      searchable.include?(user_input.downcase)
    end

    # def text_array(elements_array)
    #   elements_array.map{|element| element.text}
    # end

  end

  # def get_description(type)
  #   if

  
end
# css(".class")[2].children[1].text
# puts doc.css("#method-index")[1]
# puts doc.css(".class a").text
# all_classes_locator = "div#class-index div.entries p a"
# all_methods_locator = "div#method-list-section ul.link-list li"
# Scraper.display_content(Scraper.get_elemrnts(all_methods_locator, "Array.html")) 