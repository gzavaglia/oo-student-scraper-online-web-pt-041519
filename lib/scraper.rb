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
<<<<<<< HEAD
    while i<=names_array.length
      all << {:name => names_array[i], :location => loc_array[i], :profile_url => url_array[i]}
      i += 1
=======
    
    # names_array.each do |st_name|
    #   all << {:name => st_name, :location => loc_array[i], :profile_url => url_array[i]}
    #   i += 1
    # end
    while i<=names_array.length
      all << {:name => names_array[i], :location => loc_array[i], :profile_url => url_array[i]}
>>>>>>> d08c52314f942510220a5e805dfed99e4fa93d07
    end
    return all
  end #end method 

  def self.scrape_profile_page(profile_url)
    profile_hash = Hash.new
    profile_page = open(profile_url).read
    parsed_html = Nokogiri::HTML(profile_page)
    #st_links is the array of social media stuff for each student 
    st_links = parsed_html.css('div.social-icon-container a[href]')
    #binding.pry
    st_links_array = []
    i = 0
    st_links.select do |social|
      st_links_array << social['href']
      # binding.pry
    end
    st_links_array
    name_of_link_array = []
    
    if st_links_array.any? {|link| link.include?("twitter")}
      # name_of_link_array << :twitter
      st_links_array.each do |link|
        if link.include?("twitter")
          profile_hash[:twitter] = link
      end
    end
  end
  
  if st_links_array.any? {|link| link.include?("linkedin")}
      # name_of_link_array << :twitter
      st_links_array.each do |link|
        if link.include?("linkedin")
          profile_hash[:linkedin] = link
      end
    end
  end
  
  if st_links_array.any? {|link| link.include?("github")}
      # name_of_link_array << :twitter
      st_links_array.each do |link|
        if link.include?("github")
          profile_hash[:github] = link
      end
    end
  end
  
  
      st_links_array.each do |link|
        if !link.include?("github") && !link.include?("twitter") && !link.include?("linkedin")
          profile_hash[:blog] = link
        end
      end
  
  
    students_quote = parsed_html.css(".profile-quote").text
    students_bio = parsed_html.css(".description-holder p").text
    if !profile_hash[:profile_quote]
      profile_hash[:profile_quote] = students_quote
    end
    if !profile_hash[:bio]
      profile_hash[:bio] = students_bio
    end
    
    profile_hash
    
    
  end #end method 2 

end



