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
	
	def getCategories
		Category.all
	end

# https://github.com/ryanb/railscasts-episodes/blob/master/episode-196/revised/questionnaire-after/app/helpers/application_helper.rb
# re: https://github.com/ryanb/railscasts-episodes/blob/master/episode-196/revised/questionnaire-after/app/views/surveys/_form.html.erb
#	def link_to_add_fields(name, f, association)
#		new_object = f.object.send(association).klass.new
#		id = new_object.object_id
#		fields = f.fields_for(association, new_object, child_index: id) do |builder|
#			render(association.to_s.singularize + "_fields", f: builder)
#		end
#		link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
#	end
	
end
