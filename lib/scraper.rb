module Scraper
  @@MAIN_URI = "https://ruby-doc.org/core-2.7.2/" 
  
  def get_elements(element_locator, page)
    doc = Nokogiri::HTML(URI.open(page))
    elements = doc.css(element_locator)
  end

  def MAIN_URI
    @@MAIN_URI
  end
end
