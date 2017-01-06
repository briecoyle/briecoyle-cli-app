require 'pry'
require_relative "../lib/show.rb"

class Premiere
  attr_accessor :day, :month, :date, :shows
  @@all = []

  def initialize
    @@all << self
  end

  def self.create_from_scraper(scraper_array)
    scraper_array.each do |premiere_array|
      new_premiere = Premiere.new
      new_premiere.day = premiere_array[0]
      new_premiere.month = premiere_array[1]
      new_premiere.date = premiere_array[2]
    end
    binding.pry
  end

  def all
    @@all
  end

  def add_show(new_show)
    self.shows << new_show
    new_show.premiere << self
  end
end

test_array = [["WED", "January", "4"],
 ["THU", "January", "5"],
 ["FRI", "January", "6"],
 ["SAT", "January", "7"],
 ["SUN", "January", "8"],
 ["MON", "January", "9"],
 ["TUE", "January", "10"],
 ["WED", "January", "11"],
 ["THU", "January", "12"],
 ["FRI", "January", "13"],
 ["SAT", "January", "14"],
 ["SUN", "January", "15"],
 ["MON", "January", "16"],
 ["TUE", "January", "17"]]

Premiere.create_from_scraper(test_array)
