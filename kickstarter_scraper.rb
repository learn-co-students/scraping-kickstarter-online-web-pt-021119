require 'pry'
require 'nokogiri'
# require libraries/modules here

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
end

binding.pry

kickstarter = create_project_hash
# projects: kickstarter.css('li.project.grid_4')
