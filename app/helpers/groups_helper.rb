module GroupsHelper
	
	def current_teacher_has_group?(teacher)
		groups = Group.where("teacher_id = ?", teacher.id)
		if groups
			groups
		else
			false
		end
	end

end
