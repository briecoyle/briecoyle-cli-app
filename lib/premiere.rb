require 'pry'
require_relative "../lib/show.rb"

class Premiere
  attr_accessor :date, :shows
  @@all = []

  def initialize(date)
    @date = date
    @@all << self
  end

  def all
    @@all
  end

  def add_show(new_show)
    self.shows << new_show
    new_show.premiere << self
  end
end
