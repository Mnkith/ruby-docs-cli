require_relative './klass.rb'
class Mmethod
  extend Valid
  # include Scraper::InstanceMethods
  # attr_reader :sub_page

  @@all = []
  # @@SPECIAL_CHAR_MAP = {'[' => '5B-', ']' => '5D-',
  #                       '&' => '26-', '*' => '2A-',
  #                       '+' => '2B-', '-' => '2D-',
  #                       '<' => '3C-', '=' => '3D-',
  #                       '>' => '3E-', '?' => '3F-',
  #                       '~' => '7E-', '|' => '7C-'}
  
  attr_reader :description, :name
  def initialize(method_name, klass)
      @name = method_name
      name_index = klass.class_methods_names.index(method_name)
      # @normalized_name = self.class.normalize_name(@name)
      # @class_sub_page = klass.sub_page
      @description = klass.class_methods[name_index].text
      @@all << self
  end

  def self.all=(array)
    @@all = array
  end

  # def self.normalize_name(suffix)
  #   suffix.gsub!(/[:#]/, '')
  #   name = suffix.gsub(/[*-+=><?~\[\]]/, self.SPECIAL_CHAR_MAP) + '-method'
  #   name.gsub(/--/, '-')
  # end

  # def self.SPECIAL_CHAR_MAP
  #   @@SPECIAL_CHAR_MAP
  # end

  def self.all
    @@all
  end
end
