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
    info = premiere_page.css(".sublistbig")
  end

  def make_premieres
    premieres = self.scrape_for_premieres
    premieres.each do |premiere_info|
      new_premiere = Premiere.create_from_scraper(premiere_info)
      shows = premiere_info.scrape_for_shows
      binding.pry
      shows.each do |show_info|
        new_show = Show.create_from_scraper(show_info)
        new_premiere.add_show(new_show)
      end
    end
  end

  def scrape_for_shows
    shows = []
    premiere_page.css(".sublistbig").each do |premiere|
      shows << premiere.css(".even")
    end
    shows
  end

  def get_show_info
    scrape_for_shows.each do |show_info|
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

  def make_show
    new_show = Show.create_from_scraper(self.get_show_info)
  end
end

Scraper.new.make_premieres
