module ApplicationHelper
	
	#helper function to display a full title on every page
	def full_title(page_title)
		base_title = "Fachschaft Philosophie Uni K&ouml;ln"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end
	
	
	
	def fetchCategories
		Category.all_in_succession
	end
	
	def change_text
		'&Auml;nderungen &uuml;bernommen'.html_safe
	end
	
	def precursor_id_from_input(id)
		id = id.to_i
		id == 0 ? nil : id 	# zero because nil.to_i == 0 and ''.to_i == 0
	end
	
end
