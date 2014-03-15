module ApplicationHelper

#Returns the full title on a per-page basis.								#Documentation Comment
	def full_title(page_title)												#Method Definition
		base_title = "Ruby on Rails Tutorial Sample Application"			#variable assignment
		if page_title.empty?												#Boolean test	
			base_title														#Implicit return
		else 
			"#{base_title} | #{page_title}"									#String interpolation
		end
	end
end