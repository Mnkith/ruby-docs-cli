require_relative '../scraper.rb'
class Klass 
  extend Scraper
  @@all_classes_locator = "div#c" + "lass-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@all_methods_locator = "div#method-list-section ul.link-list li"
  @@all_classes = get_elements(@@all_classes_locator) 

  # display_content(@@all_classes)
  attr_reader :class_methods, :name, :description
  def initialize(class_name)
    @name = class_name
    @class_methods = self.class.get_elements(@@all_methods_locator, @name)
    @description = self.class.description(self)
  end

  def methods_count
    class_methods.size
  end

  def all_classes 
    @@all_classes
  end
end
k = Klass.new("String")
puts k.description
# puts k.class_methods
# puts k.all_classes
# Klass.display_content(k.class_methods)
# puts k.methods_count
# puts Klass.methods