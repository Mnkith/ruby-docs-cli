require 'nokogiri'
require 'open-uri'
module Scraper 
  module ClassMethods
  @@main_uri = "https://ruby-doc.org/core-2.7.2/" # not a constant because it's content will change dynamically
  # main_site = open(main_uri)                    # not a constant because it's content will change dynamically

    def get_elements(element_locator, uri_suffix = '')
      sub_page = open(normalize_uri(uri_suffix))
      doc = Nokogiri::HTML(sub_page)
      doc.css(element_locator)
    end
    
    def normalize_uri(suffix = '')
      return @@main_uri + suffix.gsub(/::/, '/') + '.html' if suffix != ''
      @@main_uri
    end

    def description(t)
      if t.class == Klass
        get_elements('div#documentation div#description.description', t.name).text
      else
        call =  d.css('div#count-method.method-detail span.method-callseq').text
        details = d.css('div#count-method.method-detail div p').text
        code = d.css('div#count-method.method-detail div pre').text
        "#{call}#{details}#{code}"
      end
    end
    def display_content(elements_array)
      elements_array.each_with_index {|el, i| puts "#{i+1}- #{el.text}"}
    end
  end

  module InstanceMethods

    def is_there?(user_input)
      searchable = self.all.map{|el| el.text.downcase}
      searchable.include?(user_input.downcase)
    end

    def validate(user_input) #return the valid name of method or class based on user input if found other wise nil
      searchable = self.all.map{|el| return el.text if el.text.downcase == user_input.downcase}
      nil
    end
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