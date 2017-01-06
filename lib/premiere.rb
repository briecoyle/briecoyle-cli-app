require 'pry'
require_relative "../lib/show.rb"

class Premiere
  attr_accessor :day, :month, :date, :shows
  @@all = []

  def initialize
    @@all << self
  end

  def initialize_from_scraper(scraper_array)
    scraper_array.each do |premiere_array|
      new_premiere = Premiere.new
      new_premiere.day = premiere_array[0]
      new_premiere.month = premiere_array[1]
      new_premiere.date = premiere_array[2]
    end
  end

  def all
    @@all
  end

  def add_show(new_show)
    self.shows << new_show
    new_show.premiere << self
  end
end
