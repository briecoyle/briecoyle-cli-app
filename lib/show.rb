require 'pry'
require_relative "../lib/premiere.rb"
require_relative "../lib/scraper.rb"

class Show
  attr_accessor :premiere, :title, :genre, :network, :time
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
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
    end
  end

  def add_premiere(new_premiere)
    self.premiere = new_premiere
    new_premiere.shows << self
  end

  def self.find_by_title(this_title)
    Show.all.detect{|show| show.title == this_title}
  end

  def self.find_by_genre(this_genre)
    Show.all.find_all {|show| show.genre == this_genre}
  end

  def self.find_by_network(this_network)
    Show.all.find_all {|show| show.network == this_network}
  end
end
