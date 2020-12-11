require_relative '../scraper.rb'
# require 'pry'
class Klass 
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  @@all_classes_locator = "div#c" + "lass-index div.entries p a" #ruby is a JOKE, it considers class as keyword even inside a string
  @@all_methods_locator = "div#method-list-section ul.link-list li"
  @@all = get_elements(@@all_classes_locator, "https://ruby-doc.org/core-2.7.2/")

  # display_content(@@all_classes)
  attr_reader :class_methods, :name, :description, :sub_page
  def initialize(class_name)
    if cn = self.class.validate(class_name)
      @name = cn
      @sub_page = self.class.normalize_uri(@name)
      @class_methods = self.class.get_elements(@@all_methods_locator, @sub_page)
      @description = self.descripe
      # binding.pry
    else
      puts "no #{class_name} class found"
    end
  end

  def methods_count
    class_methods.size
  end

  # def description()
  #   # binding.pry
  #   if self.class == Klass
  #     self.class.get_elements('div#documentation div#description.description', self.sub_page)
  #   else
  #     n = "#{self.normalized_name}method"
  #     call =  self.class.get_elements("div##{n}.method-detail span.method-callseq", self.klass_sub_page)
  #     details = self.class.get_elements("div##{n}.method-detail div p", self.klass_sub_page)
  #     code = self.class.get_elements("div##{n}.method-detail div pre", self.klass_sub_page)
  #     # binding.pry
  #     call.concat(details, code)
  #   end
  # end
  def self.normalize_uri(suffix = '')
    return Klass.main_uri + suffix.gsub(/::/, '/') + '.html' if suffix != ''
    Klass.main_uri
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