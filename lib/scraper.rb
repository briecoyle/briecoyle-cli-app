require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def load_page
    html = open("http://www.metacritic.com/feature/tv-premiere-dates", "User-Agent" => "Brie Coyle")
    Nokogiri::HTML(html)
  end

  def scrape_for_titles
    shows = []
    premiere_page = self.load_page
    titles = []
    premieres = premiere_page.css(".even")
#    self.load_page.css("table tr .even").each do |premiere_listing|
#        shows << {
#          :title => premiere_listing.css("td .title").text,
#          :genre => premiere_listing.css("td > .title").text,
#          :time => premiere_listing.css("td img").text,
#          :network => premiere_listing.css("td img").attribute("alt").text,
#
#        }
#        binding.pry
#    end
    binding.pry
  end

  def scrape_for_premieres
    premieres = []
    premiere_page = self.load_page
    premieres << premiere_page.css(".sublistbig").text.split("\r\n")
    clean_premieres = premieres.flatten!.grep(/([A-Z]{3}\s*\/\s*\w*\s*\d*)/)
  end

  def scrape_for_shows
    shows = []

  end
end

Scraper.new.scrape_for_titles
