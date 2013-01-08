module CategoriesHelper

	def precursor_id_from_input(id)
		id = id.to_i
		id == 0 ? nil : id 	# zero because nil.to_i == 0, ''.to_i == 0
	end

end
