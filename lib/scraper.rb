require 'nokogiri'
require 'open-uri'
module Scraper
  @@main_uri = "https://ruby-doc.org/core-2.7.2/" # not a constant because it's content will change dynamically
  # main_site = open(main_uri)                    # not a constant because it's content will change dynamically

  def get_elemrnts(element_locator, uri_suffix = "")
    sub_page = open(@@main_uri + uri_suffix)
    doc = Nokogiri::HTML(sub_page)
    doc.css(element_locator)
  end

  def display_content(elements_array)
    elements_array.each {|el| puts el.text}
  end
end
# css(".class")[2].children[1].text
# puts doc.css("#method-index")[1]
# puts doc.css(".class a").text
all_classes_locator = "div#class-index div.entries p a"
all_methods_locator = "div#method-list-section ul.link-list li"
Scraper.display_content(Scraper.get_elemrnts(all_methods_locator, "Array.html")) 