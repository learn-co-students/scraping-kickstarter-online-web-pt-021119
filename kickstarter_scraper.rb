# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  # projects: kickstarter.css('li.project.grid_4')
  # title: project.css('h2.bbcard_name strong a').text
  # image_link: project.css('div.project-thumbnail a img').attribute('src').value
  # description: project.css('p.bbcard_blurb').text
  # location: project.css('ul.project-meta li a').text 
  # didn't need to parse data-location attribute of a, since the link text will do
  # better location
  # location: project.css('ul.project-meta li a span.location-name').text
  # even better location, can leave off li and a
  # location: project.css('ul.project-meta span.location-name').text
  # funded: project.css('ul.project-stats li.first.funded strong').text.gsub('%', '').to_i



  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #binding.pry
  projects = {}
  kickstarter.css('li.project.grid_4').each {|project|
  	title = project.css('h2.bbcard_name strong a').text.to_sym
  	projects[title] = {
  		description:     project.css('p.bbcard_blurb').text,
  		image_link:      project.css('div.project-thumbnail a img').attribute('src').value,
  		location:        project.css('ul.project-meta span.location-name').text,
  		percent_funded:  project.css('ul.project-stats li.first.funded strong').text.gsub('%', '').to_i

  	}
  }
  projects
end

#create_project_hash