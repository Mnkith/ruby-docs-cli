require_relative '../scraper.rb'
class Klass 
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  @@all_classes_locator = "div#c" + "lass-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@all_methods_locator = "div#method-list-section ul.link-list li"
  @@all = get_elements(@@all_classes_locator)

  # display_content(@@all_classes)
  attr_reader :class_methods, :name, :description
  def initialize(class_name)
      if cn = self.class.validate(class_name)
      @name = cn
      @class_methods = self.class.get_elements(@@all_methods_locator, @name)
      @description = self.class.description(self)
    else
      puts "no #{class_name} class found"
    end
  end

  # def is_there?(element)

  # end
  def methods_count
    class_methods.size
  end

  def self.all
    @@all
  end
end
k = Klass.new("aRray")
puts Klass.suggest('fd')
# puts k.description
puts Klass.text_array(k.class_methods)
# puts k.all_classes
# Klass.display_content(k.class_methods)
# puts k.methods_count
# puts Klass.methods