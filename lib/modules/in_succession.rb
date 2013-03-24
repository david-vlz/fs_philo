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
				self.all.each { |object| object.update_attribute(:precursor_id, object.id-1) } # this should not be id-1 for the id might not exist in the db
				self.find(1).update_attribute(:precursor_id, nil) # for the same reason this should not be find 1
			end
		end

		# fetches all objects in order of their succession
		def all_in_succession
			all = []
			object = self.first_in_succession
			while object do
				all.push(object)
				object = object.successor
			end
			all
		end
		
		def first_in_succession
			self.where(precursor_id: nil).first
		end
		
		def last_in_succession
			self.all_in_succession.last
		end
		
		#debug, print state
		def ps(state=1)
			alt = (state == 1) ? self.all_in_succession : self.all
			alt.each { |o| puts o.id.to_s + ' ' + o.precursor_id.to_s }
			return true
		end

		def create_in_succession(attributes)
			id = self.last_in_succession.id
			attributes[:precursor_id] = self.last_in_succession.id
			self.create(attributes)
		end

		def subset_in_succession(subset)
			result = []
			ids = subset.map { |obj| obj.id }
			self.all_in_succession.each do |object|
				result.push(object) if ids.include?(object.id)
			end
			result
		end

	
	end

	def destroy_from_succession
		transaction do
			self.extract_from_succession
			self.destroy
		end
	end
	
	def precursor
		object = self.class.find_by_id(self.precursor_id)
	end

	def precursor?
		self.precursor ? true : false
	end
	
	def precursor=(object)
		object.move_before(self)
	end
	
	
	
	def successor
		self.class.where(precursor_id: id).first # TODO check for multiples raise exception
	end
	
	def successor?
		self.successor ? true : false
	end
	
	def successor=(object)
		object.move_after(self)
	end
	
	
	
	def move_top
		self.move_before(self.class.first_in_succession)
	end
	
	def move_bottom
		self.move_after(self.class.last_in_succession)
	end
	
	
	def move_before(object)
		return true if self.id == object.id
		transaction do
			self.extract_from_succession
			new_precursor_id = (object.precursor?) ? object.precursor.id : nil
			object.update_attributes!(precursor_id: self.id)
			self.update_attributes!(precursor_id: new_precursor_id)
		end
	end
	
	def move_after(object)
		return true if self.id == object.id
		transaction do
			self.extract_from_succession
			object.successor.update_attributes!(precursor_id: self.id) if object.successor?
			self.update_attributes!(precursor_id: object.id)
		end
	end
	
	
	# should obly be called within a transaction block
	def extract_from_succession
		pre = self.precursor?
		suc = self.successor?
		if (pre && suc)
			transaction do
				self.successor.update_attribute(:precursor_id, self.precursor.id)
				self.update_attribute(:precursor_id, nil)
			end
		elsif (suc && !pre)
			transaction do
				self.successor.update_attribute(:precursor_id, nil)
				self.update_attribute(:precursor_id, nil)
			end
		elsif (pre && !suc)
			self.update_attribute(:precursor_id, nil)
		end
	end
	protected :extract_from_succession
	
end
