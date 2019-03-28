# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  allprojects = {}

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  project = kickstarter.css("li.project.grid_4")
  project.each do
  |project|
  allprojects[project.css("h2.bbcard_name strong a").text.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
end
  allprojects
end



# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percentage: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i


create_project_hash
