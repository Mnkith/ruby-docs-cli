require_relative '../scraper.rb'
# require 'pry'
class Klass 
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  @@ALL_CLASSES_LOCATOR = "div#class-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@ALL_METHODS_LOCATOR = "div#method-list-section ul.link-list li"
  @@all = get_elements(@@ALL_CLASSES_LOCATOR, "https://ruby-doc.org/core-2.7.2/")

  attr_reader :class_methods, :name, :description, :sub_page

  def initialize(class_name)
      @name = self.class.validate(class_name)
      @sub_page = self.class.main_uri + self.class.normalize_name(@name)
      @class_methods = self.class.get_elements(@@ALL_METHODS_LOCATOR, @sub_page)
    end
  end

  def methods_count
    class_methods.size
  end

  def self.normalize_name(suffix = '')
    suffix.gsub(/::/, '/') + '.html' if suffix != ''
  end

  def self.all
    @@all
  end
end
# k = Klass.new("Array")
# puts Klass.all
# puts Klass.main_uri
# puts Klass.suggest('fd')
# puts k.description
# puts k.class_methods
# puts k.all_classes
# Klass.display_content(k.class_methods)
# puts k.methods_count
# puts Klass.methods
# p Klass.new('fffff')