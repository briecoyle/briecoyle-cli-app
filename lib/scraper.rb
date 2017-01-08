require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def load_page
    html = open("http://www.metacritic.com/feature/tv-premiere-dates", "User-Agent" => "Brie Coyle")
    Nokogiri::HTML(html)
  end

  def scrape_for_premieres
    premiere_page = self.load_page
    premiere_page.css(".sublistbig")
  end

  def make_premieres
    premieres = []
    premieres << self.scrape_for_premieres.text.split("\r\n")
    clean_premieres = premieres.flatten!.grep(/([A-Z]{3}\s*\/\s*\w*\s*\d*)/)
    clean_premieres.each do |info|
      Premiere.create_from_scraper(info)
      #shows =
    end
  end

  def scrape_for_shows
    shows = []
    premiere_page.css(".sublistbig").each do |premiere|
      shows << premiere.css("td")
    end
  end

  def make_shows
    Show.create_from_scraper


  end

  def scrape_for_titles
    shows = []
    premiere_page = self.load_page
    premieres = premiere_page.css(".even")
    premieres.each do |listing|
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

      shows << {
        :title => this_title,
        :genre => this_genre,
        :time => this_time,
        :network => this_network || "Netflix"
      }
    end
    binding.pry
  end

end

Scraper.new.scrape_for_titles
