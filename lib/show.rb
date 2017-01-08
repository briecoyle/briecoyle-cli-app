require 'pry'
require_relative "../lib/premiere.rb"
require_relative "../lib/scraper.rb"

class Show
  attr_accessor :premiere, :title, :genre, :network, :time
  @@all = []

  def initialize
    @@all << self
  end

  def all
    @@all
  end

  def self.create_from_scraper(show_info)
    show_info.each do |listing|
      this_title = listing.css(".title").text.strip
      this_genre = listing.css(".title + td").text.strip
      this_time = listing.css("td:last-of-type").text.strip

      if !this_time.match(/^\d/) && this_time
        modified_time = this_time.split(", ")
        this_time = modified_time[1]
        this_network = modified_time[0]
      else
        this_network = listing.css("td:last-of-type img").attribute("alt").value
      end
      new_show = Show.new
      new_show.title = this_title
      new_show.genre = this_genre
      new_show.time = this_time
      new_show.network = this_network || "Netflix"
      binding.pry
    end
  end

  def add_premiere(new_premiere)
    self.premiere = new_premiere
    new_premiere.shows << self
  end
end

Show.create_from_scraper(Scraper.new.scrape_page.css(".sublistbig ~ .even"))
