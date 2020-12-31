class Mmethod
  extend Valid

  @@all = []
  
  attr_reader :description, :name
  
  def initialize(method_name, klass)
      @name = method_name
      name_index = klass.class_methods_names.index(method_name)
      @description = klass.class_methods[name_index].text
      @@all << self
  end

  def self.all=(array)
    @@all = array
  end

  def self.all
    @@all
  end
end
