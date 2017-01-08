require 'pry'
require_relative "../lib/show.rb"
require_relative "../lib/scraper.rb"

class Premiere
  attr_accessor :day, :month, :date, :shows
  @@all = []

  def initialize
    @@all << self
  end

  def self.create_from_scraper(scraper_data)
    scraper_data.css(".sublistbig, .sublistbig~.even").each do |premiere|
      new_premiere = Premiere.new
      premiere.css(".sublistbig").each do |premiere_info|
        premiere_array = premiere.text.split("\r\n").grep(/([A-Z]{3}\s*\/\s*\w*\s*\d*)/)[0].strip.split(/\s*\/\s*|\s/)
        new_premiere.day = premiere_array[0].capitalize
        new_premiere.month = premiere_array[1]
        new_premiere.date = premiere_array[2]
      end
      premiere.css(".even").each do |shows_info|
        new_show = Show.create_from_scraper(show_info)
        new_premiere.add_show(new_show)
      end
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
