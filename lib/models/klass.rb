require_relative '../scraper.rb'
class Klass 
  extend Scraper
  
  @@all_classes = get_elements("div#c" + "lass-index div.entries p a") #ruby is a JOKE, it considers class as keyword even inside a string

  display_content(@@all_classes)
  def initialize(class_name)
    @name = class_name
    @description = []
  end
end


# puts Klass.methods