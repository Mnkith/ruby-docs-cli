require_relative './klass'
require 'pry'
class Mmethod
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  attr_reader :sub_page
  @@all = []
  @@special_chars_map = encoder = {'[' => '5B-', ']' => '5D-',
                                   '&' => '26-', '*' => '2A-',
                                   '+' => '2B-', '-' => '2D-',
                                   '<' => '3C-', '=' => '3D-',
                                   '>' => '3E-', '?' => '3F-',
                                   '~' => '7E-'}

  attr_reader :description, :name, :klass_sub_page, :normalized_name 
  def initialize(method_name, klass)
    @@all = klass.class_methods
    if mn = self.class.validate(method_name)
      @name = mn
      @normalized_name = self.class.normalize_name(@name)
      @klass_sub_page = klass.sub_page
      # @sub_page = self.class.normalize_uri(klass_sub_page, @name)
      @description = self.class.description(self)
    else
      puts "no #{method_name} method found"
    end
  end

  def self.normalize_name(suffix = '')
    suffix1 = suffix.gsub(/[:#]/, '')
    name =suffix1.gsub(/[*-+=><?~\[\]]/, self.special_chars_map) 
    # binding.pry
    return name
    # Klass.main_uri
  end

  def self.special_chars_map
    @@special_chars_map
  end

  def self.all
    @@all
  end
end

k = Klass.new("Array")
m = Mmethod.new('+', k)
# puts m.name
puts m.description
# puts Mmethod.all
