require 'pry'
require_relative "../lib/premiere.rb"

class Show
  attr_accessor :premiere, :title, :genre, :network, :time
  @@all = []

  def initialize
    @@all << self
  end

  def all
    @@all
  end

  def self.create_from_scraper(scraper_array)
    scraper_array.each do |show_hash|
      new_show = Show.new
      new_show.title = show_hash[:title]
      new_show.genre = show_hash[:genre]
      new_show.time = show_hash[:time]
      new_show.network = show_hash[:network]
      #new_show.premiere =
    end
    binding.pry
  end

  def add_premiere(new_premiere)
    self.all << new_premiere
    new_premiere.date << self
  end
end

test_shows_array = [{:title=>"Coin Heist  Trailer", :genre=>"Thriller", :time=>nil, :network=>"Netflix"},
 {:title=>"Rosewood", :genre=>"Drama", :time=>"8p", :network=>"Fox"},
 {:title=>"Sleepy Hollow", :genre=>"Drama", :time=>"9p", :network=>"Fox"},
 {:title=>"Tarzan and Jane",
  :genre=>"Animation/Family",
  :time=>nil,
  :network=>"Netflix"}]

Show.create_from_scraper(test_shows_array)
