require_relative '../environment'
# require_relative '../scraper.rb'
class Klass 
  extend Scraper, Valid
  @@ALL_CLASSES_LOCATOR = "div#class-index div.entries p a"
  @@ALL_METHODS_NAMES_LOCATOR = "div#method-list-section ul.link-list a"
  @@ALL_METHODS_LOCATOR = "div#5Buntitled-5D.documentation-section div#public-instance-method-details div.method-detail"
  
  attr_reader :class_methods, :name, :description, :class_methods_names
  
  def initialize(class_anchor)
    @name = class_anchor.text
    sub_page = self.class.main_uri + class_anchor.attr('href')
    methods_names = self.class.get_elements(@@ALL_METHODS_NAMES_LOCATOR, sub_page)
    @class_methods_names = methods_names.map{|m| m.text if m.text[0] != ':'}.compact
    @class_methods = self.class.get_elements(@@ALL_METHODS_LOCATOR, sub_page)
    @description = self.class.get_elements('div#documentation div#description.description', sub_page).text
  end
  
  def self.get_elements(element_locator, page)
    doc = Nokogiri::HTML(URI.open(page))
    elements = doc.css(element_locator)
  end
  @@ALL_CLASSES_ANCHORS = get_elements(@@ALL_CLASSES_LOCATOR, "https://ruby-doc.org/core-2.7.2/")
  @@all = @@ALL_CLASSES_ANCHORS.take(50).map{|class_anchor| Klass.new(class_anchor)}
  
  def self.all
    @@all
  end
end

# puts Klass.all[2].name