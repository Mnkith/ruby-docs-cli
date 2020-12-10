require_relative './klass'
class Mmethod
  extend Scraper::ClassMethods
  include Scraper::InstanceMethods

  @@all = []
  @@special_chars_map = encoder = {'[' => '-5B', ']' => '-5D',
                                 '&' => '-26', '*' => '-2A',
                                 '+' => '-2B', '-' => '-2D',
                                 '<' => '-3C', '=' => '-3D',
                                 '>' => '-3E', '?' => '-3F',
                                 '~' => '-7E'}

  attr_reader :description, :name
  def initialize(method_name, klass)
    @@all = kclass.class_methods
    if mn = self.class.validate(method_name)
      @name = mn
      @sub_page = self.class.normalize_uri(klass.sub_page, @name)
      @description = self.class.description(self)
    else
      puts "no #{method_name} method found"
    end
  end

  def self.normalize_uri(klass_sub_page, suffix = '')
    suffix = sffix.gsub(/#:/, '')
    return klass_sub_page + '#method-i-' suffix.gsub(/[*-+=><?\[\]]~/, @@special_chars_map) if suffix != ''
    # Klass.main_uri
  end

  def self.all
    @@all
  end
end

k = Klass.new("aRray")
m = Mmethod.new('#count', k)

puts m.description
