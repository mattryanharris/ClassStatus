class School
	def self.teacher_subdomains
		[
			"norcocollege.edu",
			"rcc.edu",
			"rccd.edu",
			"mvc.edu",
		]
	end

	def self.valid_teacher(user)
		teacher_subdomains.include? user.email.split('@').last
	end
end
