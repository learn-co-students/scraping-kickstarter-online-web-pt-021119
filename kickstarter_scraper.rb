# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html') #stores the HTML of the website
  kickstarter = Nokogiri::HTML(html) #All the data in the HTML doc

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|  #setup a loop to iterate through the projects
    title = project.css("h2.bbcard_name strong a").text
    #projects[project] = {} #and also an empty projects hash, which we will fill up with scraped data
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects #return the projects hash
end

#project = kickstarter.css("li.project.grid_4") #shorthand to call the collected of array containing our data
  #title: project.css("h2.bbcard_name strong a").first.text
  #image link: project.css("div.project-thumbnail a img").attribute("src").value
  #description: project.css("p.bbcard_blurb").first.text
  #location: project.css("span.location-name").first.text
  #percent_funded: project.css("li.first.funded strong").first.text.gsub("%", "").to_i
  #pledged: project.css("span.money.usd.no-code").first.text ->"$2,772"
#iterate through the projects
#binding.pry

create_project_hash
