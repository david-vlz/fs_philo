module InSuccession
	
	# idiom to include class methods 
	# http://railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/
	def self.included(base)
		base.extend(ClassMethods)
	end
	
	
	module ClassMethods
	
		# orders the objects according to their primary id
		def assign_natural_succession
			transaction do
				self.all.each { |object| object.update_attribute(:precursor_id, obj.id-1) } # this should not be id-1 for the id might not exist in the db
				self.find(1).update_attribute(:precursor_id, nil) # for the same reason this should not be find 1
			end
		end

		# fetches all objects in order of their succession
		def all_in_succession
			all = []
			object = self.where(precursor_id: nil).first
			(1..self.maximum('id')).each do
				all.push(object)
				object = object.successor
			end
			all
		end
		
		def ps(state=1)
			alt = (state == 1) ? self.all_in_succession : self.all
			alt.each { |o| puts o.id.to_s + ' ' + o.precursor_id.to_s }
			return true
		end
	
	end
	
	
	def successor
		self.class.where(precursor_id: id).first # TODO check for multiples raise exception
	end
	
	def successor=(object)
		transaction do
			self.extract_from_succession
			new_precursor_id = (object.precursor) ? object.precursor.id : nil
			object.update_attribute(:precursor_id, self.id)
			self.update_attribute(:precursor_id, new_precursor_id)
		end
	end
	
	
	
	private
	
		def extract_from_succession
			transaction do
				self.successor.update_attribute(:precursor_id, self.precursor.id)
				self.update_attribute(:precursor_id, nil)
			end
		end
	
end
