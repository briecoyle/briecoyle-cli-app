require 'pry'
require_relative "../lib/premiere.rb"

class Show
  attr_accessor :premiere, :title, :genre, :network, :time
  @@all = []

  def initialize(shows_hash)
    shows_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def all
    @@all
  end

  def add_premiere(new_premiere)
    self.all << new_premiere
    new_premiere.date << self
  end
end
