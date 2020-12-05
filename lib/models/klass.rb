require_relative '../scraper.rb'

class Klass 
  include Scraper

  def initialize(class_name)
    @name = class_name
    


end

# puts Klass.methods