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
		'&Auml;nderungen &uuml;bernommen! '.html_safe
	end
	
	def precursor_id_from_input(id)
		id = id.to_i
		id == 0 ? nil : id 	# zero because nil.to_i == 0 and ''.to_i == 0
	end
	
	def move_to_input_pos(object, input)
		id = precursor_id_from_input(input)
		if !id
			object.move_top
		else
			new_precursor = object.class.find(id)
			object.move_after(new_precursor)
		end
	end
	
	def string_from_time(time)
		time.strftime("%d %b. %Y, %H:%M")
	end
	
end
