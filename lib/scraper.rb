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
        #some times will include the network if not an image
        :network => this_network || "Netflix"
      }
    end
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
#titles = premieres.css(".title").text
#genres = premieres.css(".title + td").text
#time_for_broadcast = premieres.css(".even td:last-of-type").text
#time_for_streaming or network_if_image = premieres.css(".even td:last-of-type > img").attribute("alt").value
