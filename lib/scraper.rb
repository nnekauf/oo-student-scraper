require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url) #opening the html using open-uri
    doc = Nokogiri::HTML(html) #parses, or extracts the data in nested objects using nokogiri
    #variable doc now holds the parsed html
    student = []
    doc.css(".student-card").each do |klass|
       student << {
        name: klass.css("h4.student-name").text,
        location: klass.css("p.student-location").text,
        profile_url: klass.css("a").attribute("href").text
    }
      end
      student
  end

 
    #   social_url = doc.css(".social-icon-container").children.css("a").map {|x| x.attribute("href").value}

    #   social_url.each do |section|
    #     if social_url.include?("twitter")
    #       student[:twitter] = social_url 
    #     elsif social_url.include?("linkedin")  
    #       student[:linkedin] = social_url 
    #     elsif social_url.include?("github")  
    #       student[:github] = social_url 
    #     else
    #     # elsif section.css("img").children.css("src").map {|x| x.attribute("rss").value}  
    #       student[:blog] = social_url 
    #     end
    #   #the only attribute the blog has that the social medias dont is "rss" in the img.attribute(src)    
    #   end

    #   #the profile quote and bio are not in the same section as the social media

    #   student[:profile_quote] =doc.css(".profile-quote").text if doc.css(".profile-quote")
    #   student[:bio] =doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    #   student
    
  # end
  #end
#binding.pry

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_page = {}
    social_urls = doc.css(".social-icon-container").css('a').collect {|x| x.attributes["href"].value}
    
    social_urls.detect do |url|
      student_page[:twitter] = url if url.include?("twitter")
      student_page[:linkedin] = url if url.include?("linkedin")
      student_page[:github] = url if url.include?("github")
    end
    student_page[:blog] = social_urls[3] if social_urls[3] != nil
    student_page[:profile_quote] = doc.css(".profile-quote")[0].text
    student_page[:bio] = doc.css(".description-holder").css('p')[0].text
    student_page
  end


end
