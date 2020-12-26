require_relative '../environment'
require_relative '../scraper.rb'
class Klass 
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  @@ALL_CLASSES_LOCATOR = "div#class-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@ALL_METHODS_NAMES_LOCATOR = "div#method-list-section ul.link-list a"
  @@ALL_METHODS_LOCATOR = "div#5Buntitled-5D.documentation-section div#public-instance-method-details div.method-detail"
  @@ALL_CLASSES_ANCHORS= get_elements(@@ALL_CLASSES_LOCATOR, "https://ruby-doc.org/core-2.7.2/")
  # @@all = @@all_names.take(20).map{|class_name| Klass.new(class_name)}

  attr_reader :class_methods, :name, :description, :sub_page, :class_methods_names 
  
  def initialize(class_anchor)
    @name = class_anchor.text
    # binding.pry
      @sub_page = self.class.main_uri + class_anchor.attr('href')
      n = self.class.get_elements(@@ALL_METHODS_NAMES_LOCATOR, @sub_page)
      @class_methods_names = n.select{|m| m.text[0] != ':'}.map{|m| m.text}
      @class_methods = self.class.get_elements(@@ALL_METHODS_LOCATOR, @sub_page)
      @description = self.class.get_elements('div#documentation div#description.description', @sub_page).text
  end

  @@all = @@ALL_CLASSES_ANCHORS.take(50).map{|class_anchor| Klass.new(class_anchor)}

  def methods_count
    class_methods.size
  end
  
  # def self.normalize_name(suffix)
  #   suffix.gsub(/::/, '/') + '.html'
  # end
  
  def self.ALL_CLASSES_ANCHORS
    @@ALL_CLASSES_ANCHORS
  end
  
  def self.all
    @@all
  end
  # binding.pry

end

# puts Klass.all[2].name