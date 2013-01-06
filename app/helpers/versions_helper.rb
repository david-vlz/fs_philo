module VersionsHelper
	
	def whodunnit_string(version)
		uid = version.whodunnit || '?'
		user = User.find_by_id(uid.to_i) if '?' != uid
		user ? user.name : uid
	end
	
	def whodunnit_user(version)
		uid = version.whodunnit
		uid ? User.find_by_id(uid.to_i) : nil
	end
	
	def string_from_time(time)
		time.strftime("%d %b. %Y, %H:%M")
	end

end
