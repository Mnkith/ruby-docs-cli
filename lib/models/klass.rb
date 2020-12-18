require_relative '../environment'
require_relative '../scraper.rb'
class Klass 
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  @@ALL_CLASSES_LOCATOR = "div#class-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@ALL_METHODS_LOCATOR = "div#method-list-section ul.link-list li"
  @@all_names = get_elements(@@ALL_CLASSES_LOCATOR, "https://ruby-doc.org/core-2.7.2/")
  # @@all = @@all_names.take(20).map{|class_name| Klass.new(class_name)}

  attr_reader :class_methods, :name, :description, :sub_page
  
  def initialize(class_name)
      @name = class_name
      @sub_page = self.class.main_uri + @name.gsub(/::/, '/') + '.html' 
      @class_methods = self.class.get_elements(@@ALL_METHODS_LOCATOR, @sub_page)
      @description = self.class.get_elements('div#documentation div#description.description', @sub_page)
  end
  @@all = @@all_names.take(20).map{|class_name| Klass.new(class_name)}
  def methods_count
    class_methods.size
  end

  def self.normalize_name(suffix)
    suffix.gsub(/::/, '/') + '.html'
  end

  def self.all_names
    @@all_names
  end

  def self.all
    @@all
  end

end
# puts Klass.all.size