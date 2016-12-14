require 'pry'
require_relative "../lib/premiere.rb"

class Show
  attr_accessor :premiere

  @@all = []
  def all
    @@all
  end

  def add_premiere(new_premiere)
    self.all << new_premiere
    new_premiere.date << self
  end
end
