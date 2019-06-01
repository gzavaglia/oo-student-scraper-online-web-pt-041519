require 'open-uri'

require 'pry'

require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    st_hash = Hash.new
    page = open(index_url).read
    parsed_html = Nokogiri::HTML(page)
    names = parsed_html.css(".student-name")
    locations = parsed_html.css(".student-location")
    names_array = []
    names.each do |item|
      names_array << item.text
      #binding.pry
    end
    names_array.each do |student|
      if !st_hash.include?(student)
        st_hash 
      end
    end
    
   return names_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end



