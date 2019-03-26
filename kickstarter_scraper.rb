# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  html=File.read('fixtures/kickstarter.html')
  kickstarter=Nokogiri::HTML(html)
  # binding.pry

  hash = {}
  projects= kickstarter.css("li.project.grid_4")

  projects.each do |project|
    hash[project.css("h2.bbcard_name strong a").text]={
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li span.location-name").text,
      :percent_funded => project.css("li.first.funded strong").text.gsub("%","").to_i
    }
    # binding
  end
  hash
  
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value 
  # description: project.css("p.bbcard_blurb").text
  # location = project.css("ul.project-meta li span.location-name").text
  # funded = project.css("li.first.funded strong").text.gsub("%","").to_i
end