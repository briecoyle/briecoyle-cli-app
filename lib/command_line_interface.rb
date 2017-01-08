require_relative "../lib/scraper.rb"
require_relative "../lib/show.rb"
require_relative "../lib/premiere.rb"
require 'pry'

class CommandLineInterface
  def call
    Scraper.new.scrape_page
    puts "Welcome to your Tivo Television Premieres Guide!"
    start
  end

  def start
    puts ""
    puts "Here are the upcoming television premieres!"
    Premiere.all.each do |premiere|
      print_premiere(premiere)
    end
    puts ""
    puts "Is there a show about which you would like more detailed information? Please enter the show title."
    input = gets.strip
    print_show_details(Show.find_by_title(input))
    puts ""
    puts "Would you like information on another show? Enter Y or N."
    if input == "Y"
      start
    else
      puts ""
      puts "Goodbye."
    end
  end

  def print_premiere(premiere)
    puts ""
    puts "----- #{premiere.day}, #{premiere.month} #{premiere.date} -----"
    puts "#{premieres.shows}"
    puts ""
  end

  def print_show_details(show)
    puts ""
    puts "----- #{show.name} -----"
    puts "Genre: #{show.genre}"
    puts "Network: #{show.network}"
    puts "Time: #{show.time}"
    puts ""
  end
end
