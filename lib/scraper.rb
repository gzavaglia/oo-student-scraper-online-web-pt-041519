require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    all = []
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
    names_array
    
    loc_array = []
    locations.each do |city|
      loc_array << city.text
    end
    loc_array
    
    profile_url = parsed_html.css(".student-card a[href]")
    url_array = []
    profile_url.select do |each_url|
      url_array << each_url['href']
    end
    url_array
  #now we create each hash 
  
    i = 0 
    
    names_array.each do |st_name|
      all << {:name => st_name, :location => loc_array[i], :profile_url => url_array[i]}
      i += 1
    end
    return all
  end #end method 

  def self.scrape_profile_page(profile_url)
    
  end

end



