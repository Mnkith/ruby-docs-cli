require_relative './klass'
require 'pry'
require 'colorize'

class Mmethod
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods
  attr_reader :sub_page

  @@all = []
  @@SPECIAL_CHAR_MAP = {'[' => '5B-', ']' => '5D-',
                        '&' => '26-', '*' => '2A-',
                        '+' => '2B-', '-' => '2D-',
                        '<' => '3C-', '=' => '3D-',
                        '>' => '3E-', '?' => '3F-',
                        '~' => '7E-', '|' => '7C-'}

  attr_reader :description, :name, :class_sub_page, :normalized_name 
  def initialize(method_name, klass)
    # @@all = klass.class_methods
    # if @name = self.class.validate(method_name)
      @name = method_name
      @normalized_name = self.class.normalize_name(@name)
      @class_sub_page = klass.sub_page
      @description = self.descripe
    # else
    #   puts "no #{method_name} method found"
    # end
  end

  def self.all=(array)
    @@all = array
  end

  def self.normalize_name(suffix)
    suffix.gsub!(/[:#]/, '')
    name = suffix.gsub(/[*-+=><?~\[\]]/, self.SPECIAL_CHAR_MAP) + '-method'
    name.gsub(/--/, '-')
  end

  def self.SPECIAL_CHAR_MAP
    @@SPECIAL_CHAR_MAP
  end

  def self.all
    @@all
  end
end

# k = Klass.new("Array")
# puts k.class_methods.count
# m = Mmethod.new('count', k)
# puts m.name
# puts m.description
# puts Mmethod.all
