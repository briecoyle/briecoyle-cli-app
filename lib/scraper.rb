require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def load_page
    html = open("http://www.metacritic.com/feature/tv-premiere-dates", "User-Agent" => "Brie Coyle")
    premiere_page = Nokogiri::HTML(html)
    binding.pry
  end

  def self.scrape_for_premieres
    premieres = []

  end

  def self.scrape_for_shows
    shows = []

  end
end

Scraper.new.load_page
